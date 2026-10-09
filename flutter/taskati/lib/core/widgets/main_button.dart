import 'package:flutter/material.dart';
import 'package:taskati/core/functions/extensions.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
  });

  final String text;
  final Function() onPressed;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.theme.primaryColor,
        minimumSize: Size(width ?? double.infinity, height ?? 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyles.subtitle.copyWith(
          fontWeight: FontWeight.w600,
          color: DarkPalette.textPrimary,
        ),
      ),
    );
  }
}
