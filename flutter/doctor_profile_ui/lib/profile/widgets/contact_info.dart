import 'package:doctor_profile_ui/core/colors.dart';
import 'package:doctor_profile_ui/profile/widgets/details_tile.dart';
import 'package:flutter/material.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          "Contact Info",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            spacing: 10,
            children: [
              DetailsTile(icon: Icons.email_rounded, text: 'ahmed@gmail.com'),
              DetailsTile(icon: Icons.call, text: '010101010101'),
              DetailsTile(icon: Icons.call, text: '010101010101'),
            ],
          ),
        ),
      ],
    );
  }
}
