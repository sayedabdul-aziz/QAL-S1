import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/alert_dialog.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/cards/doctor_card.dart';
import 'package:se7ety/components/dialogs.dart';
import 'package:se7ety/components/inputs/custom_text_field.dart';
import 'package:se7ety/core/extentions/app_regex.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/booking/presentation/cubit/booking_cubit.dart';
import 'package:se7ety/features/patient/booking/presentation/cubit/booking_state.dart';
import 'package:se7ety/features/patient/booking/presentation/widgets/booking_date_time_picker.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _appointmentDateTime;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccessState) {
          showAlertDialog(
            context,
            title: 'تم تسجيل الحجز !',
            ok: 'اضغط للانتقال',
            onTap: () => pushToBase(context, Routes.mainPatient),
          );
        } else if (state is BookingFailureState) {
          showMyDialog(context, state.message);
        }
      },
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, BookingState state) {
    final cubit = context.read<BookingCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('احجز مع دكتورك')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              DoctorCard(doctor: cubit.doctor, isClickable: false),
              const SizedBox(height: 20),
              Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        '-- ادخل بيانات الحجز --',
                        style: TextStyles.title,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'اسم المريض',
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: cubit.nameController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل اسم المريض';
                        return null;
                      },
                      style: TextStyles.body.copyWith(),
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(15),
                    Text(
                      'رقم الهاتف',
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                    const Gap(10),
                    CustomTextField(
                      keyboardType: TextInputType.phone,
                      controller: cubit.phoneController,

                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل رقم الهاتف';
                        } else if (!AppRegex.isEgyptianMobile(value)) {
                          return 'يرجي ادخال رقم هاتف صحيح';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(15),
                    Text(
                      'وصف الحاله',
                      style: TextStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: cubit.descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      style: TextStyles.body.copyWith(),
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(15),
                    BookingDateTimePicker(
                      enabled: !state.isLocked,
                      onChanged: (value) => _appointmentDateTime = value,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: switch (state) {
          BookingLoadingState() => const SizedBox(
            height: 55,
            child: Center(child: CircularProgressIndicator()),
          ),
          BookingSuccessState() => MainButton(
            text: 'العودة للرئيسية',
            onPressed: () => pushToBase(context, Routes.mainPatient),
          ),
          BookingEditingState() || BookingFailureState() => MainButton(
            text: 'تأكيد الحجز',
            onPressed: () => _submitBooking(context, cubit),
          ),
        },
      ),
    );
  }

  void _submitBooking(BuildContext context, BookingCubit cubit) {
    if (cubit.formKey.currentState?.validate() != true) return;

    final appointmentDateTime = _appointmentDateTime;
    if (appointmentDateTime == null) {
      showMyDialog(context, 'من فضلك اختر وقت الحجز');
      return;
    }

    cubit.createAppointment(appointmentDateTime);
  }
}
