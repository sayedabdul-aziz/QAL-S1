import 'package:bmi_calculator/core/colors.dart';
import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  const GenderCard({
    super.key,
    required this.isSelected,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final bool isSelected;
  final String title;
  final IconData icon;
  final Function() onTap;

  // ternary operator
  // Color title = (isSelected) ? primary : secondary

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: .center,
            spacing: 8,
            children: [
              Icon(icon, size: 80, color: AppColors.whiteColor),

              Text(title, style: TextStyle(color: AppColors.whiteColor)),
            ],
          ),
        ),
      ),
    );
  }
}
