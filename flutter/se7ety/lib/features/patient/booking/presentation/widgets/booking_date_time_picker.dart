import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/booking/presentation/cubit/booking_cubit.dart';
import 'package:se7ety/features/patient/booking/presentation/cubit/booking_state.dart';

class BookingDateTimePicker extends StatefulWidget {
  const BookingDateTimePicker({
    super.key,
    required this.enabled,
    required this.onChanged,
  });

  final bool enabled;
  final ValueChanged<DateTime?> onChanged;

  @override
  State<BookingDateTimePicker> createState() => _BookingDateTimePickerState();
}

class _BookingDateTimePickerState extends State<BookingDateTimePicker> {
  final _dateController = TextEditingController();
  int? _selectedHour;

  @override
  void initState() {
    super.initState();
    _updateDateText(context.read<BookingCubit>().state.availability.date);
  }

  void _updateDateText(DateTime? date) {
    _dateController.text = date?.toIso8601String().split('T').first ?? '';
  }

  void _selectHour(DateTime date, int hour) {
    setState(() => _selectedHour = hour);
    widget.onChanged(DateTime(date.year, date.month, date.day, hour));
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listenWhen: (previous, current) =>
          previous.availability != current.availability &&
          current.availability is BookingAvailabilityLoading,
      listener: (context, state) {
        _updateDateText(state.availability.date);
        _selectedHour = null;
        widget.onChanged(null);
      },
      buildWhen: (previous, current) =>
          previous.availability != current.availability,
      builder: (context, state) => _buildPicker(context, state.availability),
    );
  }

  Widget _buildPicker(
    BuildContext context,
    BookingAvailabilityState availability,
  ) {
    final cubit = context.read<BookingCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تاريخ الحجز',
          style: TextStyles.body.copyWith(color: AppColors.darkColor),
        ),
        const Gap(10),
        TextFormField(
          readOnly: true,
          onTap: widget.enabled ? () => cubit.selectDate(context) : null,
          controller: _dateController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'من فضلك ادخل تاريخ الحجز';
            }
            return null;
          },
          textInputAction: TextInputAction.next,
          style: TextStyles.body.copyWith(),
          decoration: const InputDecoration(
            hintText: 'ادخل تاريخ الحجز',
            suffixIcon: Padding(
              padding: EdgeInsets.all(4.0),
              child: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                radius: 18,
                child: Icon(Icons.date_range_outlined, color: Colors.white),
              ),
            ),
          ),
        ),
        const Gap(15),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'وقت الحجز',
                style: TextStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ],
          ),
        ),
        const Gap(10),
        if (availability is BookingAvailabilityLoading)
          const Center(child: CircularProgressIndicator())
        else if (availability is BookingAvailabilityFailure) ...[
          const Text('تعذّر التحقق من المواعيد المتاحة'),
          TextButton(
            onPressed: widget.enabled ? cubit.retryAvailability : null,
            child: const Text('حاول مرة أخرى'),
          ),
        ] else if (availability case BookingAvailabilityReady(
          :final date,
          :final slots,
        ))
          if (slots.isEmpty)
            const Text('لا توجد مواعيد متاحة في هذا اليوم')
          else
            Wrap(
              spacing: 8,
              children: [
                for (final slot in slots)
                  ChoiceChip(
                    backgroundColor: AppColors.accentColor,
                    checkmarkColor: AppColors.whiteColor,
                    selectedColor: AppColors.primaryColor,
                    label: Text(
                      '${slot.hour.toString().padLeft(2, '0')}:00'
                      '${slot.isBooked ? ' (محجوز)' : ''}',
                      style: TextStyle(
                        color: slot.hour == _selectedHour
                            ? AppColors.whiteColor
                            : null,
                      ),
                    ),
                    selected: slot.hour == _selectedHour,
                    onSelected: widget.enabled && !slot.isBooked
                        ? (_) => _selectHour(date, slot.hour)
                        : null,
                  ),
              ],
            ),
      ],
    );
  }
}
