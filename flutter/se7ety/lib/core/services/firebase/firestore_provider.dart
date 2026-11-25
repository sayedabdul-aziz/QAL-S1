import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/presentation/enum/user_enum.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/auth/data/models/user_model.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';

class FirestoreProvider {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference users = FirebaseFirestore.instance
      .collection('users');
  static final doctors = FirebaseFirestore.instance.collection('doctor');
  static final CollectionReference patients = FirebaseFirestore.instance
      .collection('patient');
  static final appointment = FirebaseFirestore.instance.collection(
    'appointment',
  );

  static Future<void> createUser(UserModel user) async {
    await users.doc(user.uid).set(user.toJson());
    SharedPref.setUserData(user);
  }

  static Future<void> createDoctor(DoctorModel doctor) async {
    await doctors.doc(doctor.uid).set(doctor.toJson());
  }

  static Future<void> createPatient(PatientModel patient) async {
    await patients.doc(patient.uid).set(patient.toJson());
  }

  static Future<UserModel?> getUserById(String uid) async {
    try {
      final doc = await users.doc(uid).get();
      if (!doc.exists) return null;
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<void> updateUser(UserModel user) async {
    await users.doc(user.uid).set(user.toUpdateData(), SetOptions(merge: true));
  }

  static Future<void> updateDoctor(DoctorModel doctor) async {
    await doctors.doc(doctor.uid).update(doctor.toUpdateData());
  }

  static Future<QuerySnapshot<Object?>> getDoctorsBySpecialization(
    String specialization,
  ) async {
    // return all doctors by specialization name
    return doctors
        .where("specialization", isEqualTo: specialization, isNull: false)
        .get();
  }

  static Stream<QuerySnapshot<Object?>> sortingDoctorsRates() {
    try {
      var query = doctors
          .orderBy("rating", descending: true)
          .where("specialization", isNull: false)
          .snapshots();
      return query;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<void> createAppointment(AppointmentModel model) async {
    await appointment.doc().set(model.toJson());
  }

  static Future<void> updateAppointment(AppointmentModel model) async {
    await appointment.doc(model.id).update(model.toUpdateData());
  }

  static Future<void> deleteAppointment(String id) async {
    await appointment.doc(id).delete();
  }

  static Future<QuerySnapshot<Object?>> getAppointmentsByUserId() async {
    try {
      var user = SharedPref.getUserData();
      String field = user?.userType == UserTypeEnum.doctor.name
          ? "doctorID"
          : "patientID";
      var query = await appointment.where(field, isEqualTo: user?.uid).get();
      return query;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

// Collection => Documents => (Id, Data(Map))

//! GET
// Get All Documents => collection("doctor").get();
// Get Document By Id => collection("doctor").doc(id).get();
// Sorting/Ordering => collection("doctor").orderBy("rating", descending: true).get();
// Filtering => collection("doctor").where("specialization", isEqualTo: "طب عام").get();
// searching => collection("doctor").orderBy("name").startAt(["علي"]).endAt(["علي"+"\uf8ff"]).get();
// pagination => collection("doctor").limit(20).get();

//! SET
// Set Document => collection("doctor").doc(id).set(data);
// Add Document => collection("doctor").add(data);

//! UPDATE
// Update Document => collection("doctor").doc(id).update(data);

//! DELETE
// Delete Document => collection("doctor").doc(id).delete();
