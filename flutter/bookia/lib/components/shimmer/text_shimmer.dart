import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextShimmer extends StatelessWidget {
  const TextShimmer({
    super.key,
    required this.width,
    this.height = 14,
    this.borderRadius = 6,
    this.baseColor,
    this.highlightColor,
  });

  final double width;
  final double height;
  final double borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
