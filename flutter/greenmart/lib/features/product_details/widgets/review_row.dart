import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';

class ReviewRow extends StatelessWidget {
  const ReviewRow({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            'Review',
            style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating.floor() ? Icons.star : Icons.star_border,
                color: const Color(0xFFF3603F),
                size: 20,
              ),
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
