import 'package:flutter/material.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';

class ProductTitleRow extends StatelessWidget {
  const ProductTitleRow({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(name, style: TextStyles.headline2),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border,
            color: AppColors.greyColor,
            size: 28,
          ),
        ),
      ],
    );
  }
}
