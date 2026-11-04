import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridView extends StatelessWidget {
  const ShimmerGridView({
    super.key,
    required this.itemBuilder,
    this.itemCount = 6,
    this.crossAxisCount = 2,
    this.mainAxisExtent,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.childAspectRatio = 1.0,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.baseColor,
    this.highlightColor,
  });

  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final int crossAxisCount;
  final double? mainAxisExtent;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      child: GridView.builder(
        itemCount: itemCount,
        shrinkWrap: shrinkWrap,
        physics: physics ?? const NeverScrollableScrollPhysics(),
        padding: padding,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisExtent: mainAxisExtent,
          childAspectRatio: mainAxisExtent != null ? 1.0 : childAspectRatio,
        ),
        itemBuilder: itemBuilder,
      ),
    );
  }
}
