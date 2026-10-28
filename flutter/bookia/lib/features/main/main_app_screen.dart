import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/custom_svg_image.dart';
import 'package:bookia/features/home/presentation/page/home_screen.dart';
import 'package:flutter/material.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: CustomSvgImage(path: AppImages.homeSvg),
            activeIcon: CustomSvgImage(
              path: AppImages.homeSvg,
              color: LightPalette.primaryColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomSvgImage(path: AppImages.bookmarkSvg),
            activeIcon: CustomSvgImage(
              path: AppImages.bookmarkSvg,
              color: LightPalette.primaryColor,
            ),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: CustomSvgImage(path: AppImages.categorySvg),
            activeIcon: CustomSvgImage(
              path: AppImages.categorySvg,
              color: LightPalette.primaryColor,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: CustomSvgImage(path: AppImages.profileSvg),
            activeIcon: CustomSvgImage(
              path: AppImages.profileSvg,
              color: LightPalette.primaryColor,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
