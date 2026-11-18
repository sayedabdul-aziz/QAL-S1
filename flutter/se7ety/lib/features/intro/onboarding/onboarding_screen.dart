import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/intro/onboarding/onboarding_model.dart';
import 'package:se7ety/generated/locale_keys.g.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pageController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        actions: [
          IconButton(
            onPressed: () {
              bool isArabic = context.locale.languageCode == 'ar';
              context.setLocale(
                isArabic ? const Locale('en') : const Locale('ar'),
              );
            },
            icon: Icon(Icons.language, color: AppColors.primaryColor),
          ),
          Spacer(),
          if (isLast == false)
            TextButton(
              onPressed: () {
                SharedPref.setOnboarding();
                pushWithReplacement(context, Routes.welcome);
              },
              child: Text(
                LocaleKeys.skip.tr(),
                style: TextStyles.body.copyWith(color: AppColors.primaryColor),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // pageView
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingList.length,
                onPageChanged: (index) {
                  setState(() {
                    isLast = index == onboardingList.length - 1;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Spacer(flex: 1),
                      SvgPicture.asset(onboardingList[index].image, width: 300),
                      const SizedBox(height: 30),
                      Text(
                        onboardingList[index].title,
                        style: TextStyles.title.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        onboardingList[index].description,
                        style: TextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(flex: 4),
                    ],
                  );
                },
              ),
            ),
            // buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: onboardingList.length,
                  onDotClicked: (index) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  effect: const ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: AppColors.greyColor,
                    activeDotColor: AppColors.primaryColor,
                  ),
                ),
                MainButton(
                  width: 100,
                  height: 45,
                  text: isLast ? 'ابدأ' : 'التالي',
                  onPressed: () {
                    if (isLast) {
                      SharedPref.setOnboarding();
                      pushWithReplacement(context, Routes.welcome);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // button
          ],
        ),
      ),
    );
  }
}
