import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/auth/data/models/user_model.dart';

class FirestoreProvider {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference users = FirebaseFirestore.instance
      .collection('users');
  static final CollectionReference doctors = FirebaseFirestore.instance
      .collection('doctor');
  static final CollectionReference patients = FirebaseFirestore.instance
      .collection('patient');

  static Future<void> createUser(UserModel user) async {
    await users.doc(user.uid).set(user.toJson());
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
}
