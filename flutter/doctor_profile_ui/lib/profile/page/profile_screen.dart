import 'package:doctor_profile_ui/core/colors.dart';
import 'package:doctor_profile_ui/profile/widgets/address_details.dart';
import 'package:doctor_profile_ui/profile/widgets/contact_info.dart';
import 'package:doctor_profile_ui/profile/widgets/main_button.dart';
import 'package:doctor_profile_ui/profile/widgets/profile_header.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileHeader(),
                    SizedBox(height: 16),
                    Text(
                      "About",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Professor of Eye Special - Former Head of Department of Eye Special, Cairo University. Professor of Eye Special - Former Head of Department of Eye Special, Cairo University",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    AddressDetails(),
                    Divider(indent: 16, endIndent: 16, thickness: 1.5),
                    SizedBox(height: 16),
                    ContactInfo(),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // ACTIONS
            SizedBox(height: 5),
            MainButton(
              bgColor: Colors.green,
              text: 'Chat With Doctor',
              onPressed: () {},
            ),
            SizedBox(height: 10),
            MainButton(text: 'Book Appointment', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
