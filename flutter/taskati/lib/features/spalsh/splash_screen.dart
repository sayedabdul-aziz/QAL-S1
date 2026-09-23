import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/naviagtions.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/core/widgets/my_scaffold.dart';
import 'package:taskati/features/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      pushReplacement(context, const HomeScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppImages.logoLottie, width: 250),
            const Gap(16),
            Text(
              'Taskati',
              style: TextStyles.headline2.copyWith(fontWeight: FontWeight.w500),
            ),
            const Gap(8),
            Text(
              'It\'s time to get organized',
              style: TextStyles.body.copyWith(
                fontWeight: FontWeight.normal,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
