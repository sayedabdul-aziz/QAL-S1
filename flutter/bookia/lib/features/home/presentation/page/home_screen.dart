import 'package:bookia/core/constants/app_design.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/widgets/custom_svg_image.dart';
import 'package:bookia/features/home/presentation/widgets/best_sellers_books.dart';
import 'package:bookia/features/home/presentation/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: CustomSvgImage(path: AppImages.logoSvg, height: 32),
        actions: [
          IconButton(
            icon: CustomSvgImage(path: AppImages.searchSvg),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDesign.CONTENT_PADDING),
        child: Column(children: [HomeSlider(), Gap(16), BestSellersBooks()]),
      ),
    );
  }
}
