import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';
import 'package:greenmart/features/shop/data/product_model.dart';
import 'package:greenmart/features/shop/widgets/product_card.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key, required this.title, required this.list});

  final String title;
  final List<ProductModel> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyles.title1),
            TextButton(
              onPressed: () {},
              child: Text(
                'See all',
                style: TextStyles.body.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var product = list[index];
              return ProductCard(product: product);
            },
            separatorBuilder: (context, index) => const Gap(10),
            itemCount: list.length,
          ),
        ),
      ],
    );
  }
}
