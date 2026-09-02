import 'package:bmi_calculator/core/colors.dart';
import 'package:flutter/material.dart';

class HeightSelection extends StatefulWidget {
  const HeightSelection({super.key, required this.onHeightChanged});
  final Function(int) onHeightChanged;

  @override
  State<HeightSelection> createState() => _HeightSelectionState();
}

class _HeightSelectionState extends State<HeightSelection> {
  double height = 180;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Text(
              'Height',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  height.round().toString(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: AppColors.whiteColor,
                  ),
                ),
                Text(
                  'cm',
                  style: TextStyle(fontSize: 20, color: AppColors.whiteColor),
                ),
              ],
            ),
            Slider(
              value: height, // current value
              min: 80,
              max: 220,
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.grayColor,
              onChanged: (value) {
                // update value
                setState(() {
                  height = value;
                });
                widget.onHeightChanged(value.round());
              },
            ),
          ],
        ),
      ),
    );
  }
}
