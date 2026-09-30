import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/core/widgets/custom_svg_image.dart';

class DateTimeField extends StatelessWidget {
  const DateTimeField({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.errorMsg,
  });

  final String leading;
  final String title;
  final String subtitle;
  final String? errorMsg;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor,
            blurRadius: 20,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          leading: CustomSvgImage(path: leading),
          title: Text(
            title,
            style: TextStyles.caption2.copyWith(color: AppColors.greyColor),
          ),
          subtitle: Text(
            errorMsg ?? subtitle,
            style: TextStyles.body.copyWith(
              fontWeight: errorMsg != null
                  ? FontWeight.normal
                  : FontWeight.w500,
              fontSize: errorMsg != null ? 12 : 14,
              color: errorMsg != null
                  ? AppColors.redColor
                  : AppColors.blackColor,
            ),
          ),
          trailing: CustomSvgImage(path: AppImages.downSvg),
          onTap: onTap,
        ),
      ),
    );
  }
}
