import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:greenmart/core/constants/app_images.dart';
import 'package:greenmart/core/functions/naviagtions.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';
import 'package:greenmart/core/widgets/main_button.dart';
import 'package:greenmart/features/auth/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcome,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          Positioned(
            bottom: 60,
            right: 20,
            left: 20,
            child: Column(
              mainAxisSize: .min,
              children: [
                SvgPicture.asset(
                  AppImages.carrotSvg,
                  colorFilter: const ColorFilter.mode(
                    AppColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
                const Gap(10),
                Text(
                  'Welcome\nto our store',
                  textAlign: TextAlign.center,
                  style: TextStyles.headline1.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 40,
                    height: 1.2,
                  ),
                ),
                const Gap(10),
                Text(
                  'Ger your groceries in as fast as one hour',
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
                const Gap(20),
                MainButton(
                  onPressed: () {
                    pushReplacement(context, const LoginScreen());
                  },
                  text: "Get Started",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
