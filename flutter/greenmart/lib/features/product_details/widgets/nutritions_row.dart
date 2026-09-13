import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';

class NutritionsRow extends StatelessWidget {
  const NutritionsRow({super.key, required this.nutrition});

  final String nutrition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            'Nutritions',
            style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              nutrition,
              style: TextStyles.caption2.copyWith(color: AppColors.greyColor),
            ),
          ),
          const Gap(8),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.greyColor,
          ),
        ],
      ),
    );
  }
}
