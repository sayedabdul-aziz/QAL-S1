import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:greenmart/core/constants/app_images.dart';
import 'package:greenmart/core/functions/naviagtions.dart';
import 'package:greenmart/core/styles/app_colors.dart';
import 'package:greenmart/core/styles/text_styles.dart';
import 'package:greenmart/core/widgets/custom_text_field.dart';
import 'package:greenmart/core/widgets/main_button.dart';
import 'package:greenmart/features/auth/signup_screen.dart';
import 'package:greenmart/features/main/main_app_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(AppImages.carrotSvg),
                    ),
                    const Gap(40),
                    const Text('Login', style: TextStyles.headline2),
                    const Gap(16),
                    Text(
                      'Enter your email and password',
                      style: TextStyles.body.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                    const Gap(40),
                    CustomTextField(
                      title: 'Email',
                      hintText: 'example@gmail.com',
                      validator: (input) {
                        if (input?.isEmpty == true) {
                          return 'Please enter your email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Gap(10),
                    CustomTextField(
                      title: 'Password',
                      hintText: '********',
                      validator: (input) {
                        if (input?.isEmpty == true) {
                          return 'Please enter your password';
                        } else {
                          return null;
                        }
                      },
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyles.body.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    MainButton(
                      text: 'Login',
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          pushReplacement(context, const MainAppScreen());
                        } else {
                          // error
                        }
                      },
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyles.caption1,
                        ),
                        TextButton(
                          onPressed: () {
                            pushReplacement(context, const SignUpScreen());
                          },
                          style: TextButton.styleFrom(
                            minimumSize: .zero,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                          ),
                          child: Text(
                            'Sign Up',
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
      ),
    );
  }
}

// Validations

// Form Widget => formKey
// text form field (validator) => String?
// action => onPressed (formKey.validate())
