import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/naviagtions.dart';
import 'package:bookia/core/routes/route_names.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/components/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var user = SharedPref.getUserData();
    Future.delayed(Duration(seconds: 3), () {
      if (user != null) {
        pushReplacement(context, RouteNames.main);
      } else {
        pushReplacement(context, RouteNames.welcome);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgImage(path: AppImages.logoSvg, width: 250),
            const Gap(16),
            Text('Order Your Book Now!', style: TextStyles.body),
          ],
        ),
      ),
    );
  }
}
