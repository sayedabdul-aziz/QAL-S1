import 'package:doctor_profile_ui/core/colors.dart';
import 'package:doctor_profile_ui/profile/widgets/call_button.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNKS7jAtuaffId_E1ozWbrCfOYuJhot8MfahbfFJ9gnw&s=10',
            width: 140,
            height: 140,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Ahmed Ali Ahmed',
                maxLines: 2,
                overflow: .ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                'Dentist',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 4),
                  Text('3'),
                ],
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  CallButton(text: '1'),
                  SizedBox(width: 10),
                  CallButton(text: '2'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
