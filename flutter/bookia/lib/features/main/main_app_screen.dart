import 'package:bookia/components/custom_svg_image.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/page/home_screen.dart';
import 'package:bookia/features/wishlist/presentation/wishlist/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/wishlist/page/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Person p = Person()..name = 'ahmed'.. display();
// p.name = '';
// p.display();

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;

  List<Widget> pages = [
    BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => WishlistCubit()..getWishlist(),
      child: WishlistScreen(),
    ),
    HomeScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
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
