import 'package:flutter/material.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';

class ProductDetailSection extends StatelessWidget {
  const ProductDetailSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        initiallyExpanded: true,
        title: Text(
          'Product Detail',
          style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              description,
              style: TextStyles.caption1.copyWith(
                color: AppColors.greyColor,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
