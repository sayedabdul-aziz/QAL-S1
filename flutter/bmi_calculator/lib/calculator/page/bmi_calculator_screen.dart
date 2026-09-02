import 'package:bmi_calculator/calculator/page/result_screen.dart';
import 'package:bmi_calculator/calculator/widgets/gender_card.dart';
import 'package:bmi_calculator/calculator/widgets/height_age_selection.dart';
import 'package:bmi_calculator/calculator/widgets/height_selection.dart';
import 'package:bmi_calculator/calculator/widgets/main_button.dart';
import 'package:bmi_calculator/core/colors.dart';
import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool isMale = true;
  int height = 180;
  int age = 18;
  int weight = 60;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'BMI Calculator',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            // gender
            buildGender(),

            // height
            HeightSelection(
              onHeightChanged: (value) {
                height = value;
              },
            ),

            // weight and age
            Expanded(
              child: Row(
                spacing: 16,
                children: [
                  HeightAgeSelection(
                    title: 'Weight',
                    initValue: weight,
                    onValueChange: (value) {
                      weight = value;
                    },
                  ),
                  HeightAgeSelection(
                    title: 'Age',
                    initValue: age,
                    onValueChange: (value) {
                      age = value;
                    },
                  ),
                ],
              ),
            ),

            // button
            MainButton(
              title: 'Calculate',
              onTap: () {
                // Formula: BMI = (weight / height^2) * 10000
                double bmi = weight / (height * height) * 10000;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(result: bmi),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildGender() {
    return Expanded(
      child: Row(
        spacing: 16,
        children: [
          GenderCard(
            isSelected: isMale,
            title: 'Male',
            icon: Icons.male,
            onTap: () {
              setState(() {
                isMale = true;
              });
            },
          ),
          GenderCard(
            isSelected: !isMale,
            title: 'Female',
            icon: Icons.female,
            onTap: () {
              setState(() {
                isMale = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
