import 'package:bookia/components/custom_svg_image.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/naviagtions.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.onBackPressed,
    this.hasBack = true,
  });

  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Function()? onBackPressed;
  final bool hasBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 75,
      leading: hasBack == false
          ? null
          : leading ??
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
