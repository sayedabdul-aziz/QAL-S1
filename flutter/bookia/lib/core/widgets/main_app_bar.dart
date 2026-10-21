import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/naviagtions.dart';
import 'package:bookia/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.onBackPressed,
  });

  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 75,
      leading:
          leading ??
          Center(
            child: InkWell(
              onTap: onBackPressed ?? () => pop(context),
              child: CustomSvgImage(path: AppImages.backSvg, width: 42),
            ),
          ),
      title: Text(title ?? ''),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
