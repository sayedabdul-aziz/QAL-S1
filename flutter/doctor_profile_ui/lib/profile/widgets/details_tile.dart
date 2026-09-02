import 'package:doctor_profile_ui/core/colors.dart';
import 'package:flutter/material.dart';

class DetailsTile extends StatelessWidget {
  const DetailsTile({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.primaryColor,
          child: Icon(icon, color: AppColors.whiteColor, size: 20),
        ),
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}



// separate widgets (clean code (more lines / diff sections) , shared components)