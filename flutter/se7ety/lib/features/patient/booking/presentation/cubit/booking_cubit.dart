import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';
import 'package:se7ety/features/patient/booking/data/repo/booking_availability_repo.dart';
import 'package:se7ety/features/patient/booking/presentation/cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this.doctor) : super(const BookingEditingState());

  final DoctorModel doctor;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  final _availabilityRepo = BookingAvailabilityRepo();

  Future<void> selectDate(BuildContext context) async {
    if (state.isLocked) return;

    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      selectableDayPredicate: (day) => day.weekday != DateTime.friday,
    );
    if (date == null || !context.mounted || isClosed || state.isLocked) return;

    await _loadAvailability(date);
  }

  Future<void> retryAvailability() async {
    final availability = state.availability;
    if (state.isLocked || availability is! BookingAvailabilityFailure) return;

    await _loadAvailability(availability.date);
  }

  Future<void> _loadAvailability(DateTime date) async {
    final loading = BookingAvailabilityLoading(date);
    emit(BookingEditingState(loading));

    try {
      final slots = await _availabilityRepo.getSlots(
        doctorId: doctor.uid,
        date: date,
        openHour: doctor.openHour,
        closeHour: doctor.closeHour,
      );
      if (isClosed || state.availability != loading) return;

      emit(BookingEditingState(BookingAvailabilityReady(date, slots)));
    } catch (error, stackTrace) {
      if (isClosed || state.availability != loading) return;

      addError(error, stackTrace);
      emit(BookingEditingState(BookingAvailabilityFailure(date)));
    }
  }

  Future<void> createAppointment(DateTime appointmentDateTime) async {
    if (state.isLocked) return;

    final availability = state.availability;
    if (availability is! BookingAvailabilityReady) return;

    emit(BookingLoadingState(availability));
    try {
      final appointment = AppointmentModel(
        patientID: SharedPref.getUserData()?.uid ?? '',
        doctorID: doctor.uid ?? '',
        doctorName: doctor.name ?? '',
        name: nameController.text,
        phone: phoneController.text,
        description: descriptionController.text,
        location: doctor.address ?? '',
        date: appointmentDateTime,
        isComplete: false,
      );
      await FirestoreProvider.createAppointment(appointment);
      if (!isClosed) emit(BookingSuccessState(availability));
    } catch (error, stackTrace) {
      if (isClosed) return;

      addError(error, stackTrace);
      emit(
        BookingFailureState(availability, 'تعذّر تسجيل الحجز. حاول مرة أخرى'),
      );
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
