import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:greenmart/core/constants/app_design.dart';
import 'package:greenmart/core/constants/app_images.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';
import 'package:greenmart/core/widgets/custom_svg_image.dart';
import 'package:greenmart/core/widgets/custom_text_field.dart';
import 'package:greenmart/features/shop/data/dummy_data.dart';
import 'package:greenmart/features/shop/widgets/home_carousel.dart';
import 'package:greenmart/features/shop/widgets/home_grid.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomSvgImage(
          path: AppImages.logoSvg,
          color: AppColors.primaryColor,
          height: 50,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDesign.CONTENT_PADDING),
        child: Column(
          children: [
            const CustomTextField(
              prefixIcon: Icon(Icons.search, color: AppColors.greyColor),
              hintText: 'Search for products ..',
            ),
            const Gap(12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    HomeCarousel(title: 'Exclusive Offer', list: offersList),
                    HomeCarousel(title: 'Best Selling', list: bestSellingList),
                    // Picks for you (Vertical scroll, GridView)
                    const Text("Picks for you", style: TextStyles.title1),
                    ProductsGrid(list: allProducts),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
