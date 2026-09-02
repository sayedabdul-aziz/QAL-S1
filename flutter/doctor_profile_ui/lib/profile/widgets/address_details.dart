import 'package:doctor_profile_ui/core/colors.dart';
import 'package:doctor_profile_ui/profile/widgets/details_tile.dart';
import 'package:flutter/material.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 10,
        children: [
          DetailsTile(
            icon: Icons.local_hospital_rounded,
            text: 'Cairo Hospital',
          ),
          DetailsTile(
            icon: Icons.watch_later_rounded,
            text: 'Cairo Hospital',
          ),
          DetailsTile(
            icon: Icons.location_on,
            text: 'Nasr City, Cairo',
          ),
        ],
      ),
    );
  }
}
