import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/naviagtions.dart';
import 'package:bookia/core/routes/route_names.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_image.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppImages.welcome, fit: BoxFit.cover),
          ),

          Positioned(
            top: 0,
            left: 20,
            right: 20,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                CustomSvgImage(path: AppImages.logoSvg, width: 220),
                const Gap(16),
                Text('Order Your Book Now!', style: TextStyles.subtitle),
                Spacer(flex: 5),
                MainButton(
                  text: 'Login',
                  onPressed: () {
                    pushTo(context, RouteNames.login);
                  },
                ),
                const Gap(16),
                MainButton(
                  borderColor: LightPalette.textPrimary,
                  textColor: LightPalette.textPrimary,
                  bgColor: LightPalette.whiteColor,
                  text: 'Sign Up',
                  onPressed: () {
                    pushTo(context, RouteNames.register);
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
