import 'package:se7ety/features/patient/booking/data/repo/booking_availability_repo.dart';

sealed class BookingState {
  const BookingState(this.availability);

  final BookingAvailabilityState availability;

  bool get isLocked =>
      this is BookingLoadingState || this is BookingSuccessState;
}

final class BookingEditingState extends BookingState {
  const BookingEditingState([
    super.availability = const BookingAvailabilityInitial(),
  ]);
}

final class BookingLoadingState extends BookingState {
  const BookingLoadingState(super.availability);
}

final class BookingSuccessState extends BookingState {
  const BookingSuccessState(super.availability);
}

final class BookingFailureState extends BookingState {
  const BookingFailureState(super.availability, this.message);

  final String message;
}

sealed class BookingAvailabilityState {
  const BookingAvailabilityState();

  DateTime? get date;
}

final class BookingAvailabilityInitial extends BookingAvailabilityState {
  const BookingAvailabilityInitial();

  @override
  DateTime? get date => null;
}

final class BookingAvailabilityLoading extends BookingAvailabilityState {
  const BookingAvailabilityLoading(this.date);

  @override
  final DateTime date;
}

final class BookingAvailabilityReady extends BookingAvailabilityState {
  const BookingAvailabilityReady(this.date, this.slots);

  @override
  final DateTime date;
  final List<BookingSlot> slots;
}

final class BookingAvailabilityFailure extends BookingAvailabilityState {
  const BookingAvailabilityFailure(this.date);

  @override
  final DateTime date;
}
