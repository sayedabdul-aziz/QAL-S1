import 'package:flutter/material.dart';
import 'package:se7ety/components/cards/doctor_card.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/patient/home/presentation/page/specialization_search_screen.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.doctors});

  final List<DoctorModel> doctors;

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) {
      return const EmptyWidget(message: 'لا يوجد أطباء مطابقون للبحث');
    }

    return Scrollbar(
      child: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) => DoctorCard(doctor: doctors[index]),
      ),
    );
  }
}
