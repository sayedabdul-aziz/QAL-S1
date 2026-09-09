import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:greenmart/core/constants/app_images.dart';
import 'package:greenmart/core/functions/naviagtions.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';
import 'package:greenmart/core/widgets/custom_text_field.dart';
import 'package:greenmart/core/widgets/main_button.dart';
import 'package:greenmart/features/auth/login_screen.dart';
import 'package:greenmart/features/main/main_app_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(AppImages.carrotSvg),
                  ),
                  const Gap(40),
                  const Text('Sign Up', style: TextStyles.headline2),
                  const Gap(16),
                  Text(
                    'Enter your credentials to continue',
                    style: TextStyles.body.copyWith(color: AppColors.greyColor),
                  ),
                  const Gap(40),
                  const CustomTextField(title: 'Name', hintText: 'John Doe'),
                  const Gap(10),
                  const CustomTextField(
                    title: 'Email',
                    hintText: 'example@gmail.com',
                  ),
                  const Gap(10),
                  const CustomTextField(
                    title: 'Password',
                    hintText: '********',
                  ),

                  const Gap(40),
                  MainButton(
                    text: 'Sign Up',
                    onPressed: () {
                      pushReplacement(context, const MainAppScreen());
                    },
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyles.caption1,
                      ),
                      TextButton(
                        onPressed: () {
                          pushReplacement(context, const LoginScreen());
                        },
                        style: TextButton.styleFrom(
                          minimumSize: .zero,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyles.caption1.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
