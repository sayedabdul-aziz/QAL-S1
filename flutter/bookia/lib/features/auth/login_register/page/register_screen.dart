import 'package:bookia/core/constants/app_design.dart';
import 'package:bookia/core/routes/naviagtions.dart';
import 'package:bookia/core/routes/route_names.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_password_field.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/core/widgets/main_app_bar.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/auth/login_register/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppDesign.CONTENT_PADDING),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                Text(
                  'Hello! Register to get started',
                  style: TextStyles.headline1,
                ),
                const Gap(32),
                CustomTextField(
                  hintText: 'Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const Gap(16),
                CustomTextField(
                  hintText: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const Gap(16),
                CustomPasswordField(
                  hintText: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const Gap(16),
                CustomPasswordField(
                  hintText: 'Confirm Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                const Gap(32),
                MainButton(
                  text: 'Register',
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.register();
                    }
                  },
                ),
                const Gap(32),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppDesign.CONTENT_PADDING),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account? ', style: TextStyles.body),
            TextButton(
              onPressed: () {
                pushReplacement(context, RouteNames.login);
              },
              child: Text(
                'Login',
                style: TextStyles.body.copyWith(
                  color: LightPalette.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
