import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 56,
    this.textColor = LightPalette.whiteColor,
    this.bgColor = LightPalette.primaryColor,
    this.borderColor,
    this.icon,
  });

  final String text;
  final Function() onPressed;
  final double width;
  final double height;
  final Color textColor;
  final Color bgColor;
  final Color? borderColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: Size(width, height),
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[icon!, const Gap(8)],
          Text(text, style: TextStyles.body.copyWith(color: textColor)),
        ],
      ),
    );
  }
}
