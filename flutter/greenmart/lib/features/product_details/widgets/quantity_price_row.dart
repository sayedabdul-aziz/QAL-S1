import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';

class QuantityPriceRow extends StatelessWidget {
  const QuantityPriceRow({
    super.key,
    required this.quantity,
    required this.price,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final double price;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onDecrement,
              child: const Icon(
                Icons.remove,
                size: 28,
                color: AppColors.greyColor,
              ),
            ),
            const Gap(16),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: Text(
                '$quantity',
                style: TextStyles.subtitle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(16),
            GestureDetector(
              onTap: onIncrement,
              child: const Icon(
                Icons.add,
                size: 28,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        Text(
          '\$${(price * quantity).toStringAsFixed(2)}',
          style: TextStyles.title2.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
