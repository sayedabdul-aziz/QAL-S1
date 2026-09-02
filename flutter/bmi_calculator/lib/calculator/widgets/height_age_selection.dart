import 'package:bmi_calculator/core/colors.dart';
import 'package:flutter/material.dart';

class HeightAgeSelection extends StatefulWidget {
  const HeightAgeSelection({
    super.key,
    required this.title,
    required this.initValue,
    required this.onValueChange,
  });

  final String title;
  final int initValue;
  final Function(int) onValueChange;

  @override
  State<HeightAgeSelection> createState() => _HeightAgeSelectionState();
}

class _HeightAgeSelectionState extends State<HeightAgeSelection> {
  int _initValue = 0;

  @override
  void initState() {
    _initValue = widget.initValue;
    super.initState();
  }

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
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
              ),
            ),
            Text(
              _initValue.toString(),
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: AppColors.whiteColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.grayColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _initValue--;
                    });
                    widget.onValueChange(_initValue);
                  },
                  icon: const Icon(Icons.remove),
                ),
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.grayColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _initValue++;
                    });
                    widget.onValueChange(_initValue);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
