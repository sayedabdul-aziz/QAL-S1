import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListView extends StatelessWidget {
  const ShimmerListView({
    super.key,
    required this.itemBuilder,
    this.itemCount = 6,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.separatorBuilder,
    this.baseColor,
    this.highlightColor,
  });

  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      child: separatorBuilder != null
          ? ListView.separated(
              itemCount: itemCount,
              scrollDirection: scrollDirection,
              shrinkWrap: shrinkWrap,
              physics: physics ?? const NeverScrollableScrollPhysics(),
              padding: padding,
              separatorBuilder: separatorBuilder!,
              itemBuilder: itemBuilder,
            )
          : ListView.builder(
              itemCount: itemCount,
              scrollDirection: scrollDirection,
              shrinkWrap: shrinkWrap,
              physics: physics ?? const NeverScrollableScrollPhysics(),
              padding: padding,
              itemBuilder: itemBuilder,
            ),
    );
  }
}
