import 'package:se7ety/core/extentions/extension.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';

class BookingAvailabilityRepo {
  Future<List<BookingSlot>> getSlots({
    required String? doctorId,
    required DateTime date,
    required String? openHour,
    required String? closeHour,
  }) async {
    if (doctorId == null || doctorId.isEmpty) {
      throw StateError('A doctor ID is required to check availability.');
    }

    final snapshot = await FirestoreProvider.appointment
        .where('doctorID', isEqualTo: doctorId)
        .get();

    final List<DateTime> bookedDates = [];
    for (final doc in snapshot.docs) {
      final appointment = AppointmentModel.fromJson(doc.data());
      if (appointment.date != null) {
        bookedDates.add(appointment.date!);
      }
    }

    return getBookingSlots(
      date,
      openHour ?? '0',
      closeHour ?? '0',
      bookedAppointments: bookedDates,
    );
  }
}

List<BookingSlot> getBookingSlots(
  DateTime selectedDate,
  String start,
  String end, {
  Iterable<DateTime> bookedAppointments = const [],
}) {
  final startHour = int.parse(start);
  final endHour = int.parse(end);
  final firstAvailableHour = isToday(selectedDate)
      ? DateTime.now().hour + 1
      : 0;
  final bookedHours = <int>{};
  for (final appointment in bookedAppointments) {
    final date = appointment.toLocal();
    if (date.year == selectedDate.year &&
        date.month == selectedDate.month &&
        date.day == selectedDate.day) {
      bookedHours.add(date.hour);
    }
  }

  List<BookingSlot> slots = [];
  for (var hour = startHour; hour < endHour; hour++) {
    if (hour >= firstAvailableHour) {
      slots.add(BookingSlot(hour: hour, isBooked: bookedHours.contains(hour)));
    }
  }

  return slots;
}

class BookingSlot {
  final int hour;
  final bool isBooked;

  const BookingSlot({required this.hour, required this.isBooked});
}
