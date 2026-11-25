import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/components/cards/doctor_card.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';

class TopRatedList extends StatefulWidget {
  const TopRatedList({super.key});

  @override
  State<TopRatedList> createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirestoreProvider.sortingDoctorsRates(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            // state is! success
            return const Center(
              child: CircularProgressIndicator(
                value: .9,
                color: Colors.black12,
              ),
            );
          } else {
            var docs = snapshot.data?.docs;
            if (docs?.isEmpty == true) {
              return const Center(child: Text('لا يوجد دكتور '));
            }
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: docs?.length, // all doctors in firebase
              itemBuilder: (context, index) {
                DoctorModel doctor = DoctorModel.fromJson(
                  docs?[index].data() as Map<String, dynamic>,
                );
                return DoctorCard(doctor: doctor);
              },
            );
          }
        },
      ),
    );
  }
}
