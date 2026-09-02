import 'package:doctor_profile_ui/core/colors.dart';
import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(children: [Icon(Icons.call), Text(text)]),
    );
  }
}
