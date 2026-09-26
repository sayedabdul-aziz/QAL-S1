import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/widgets/my_scaffold.dart';
import 'package:taskati/features/home/widgets/daily_progress.dart';
import 'package:taskati/features/home/widgets/home_header.dart';
import 'package:taskati/features/home/widgets/tasks_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        spacing: 20,
        children: [
          HomeHeader(),
          DailyProgress(progress: 0.5),
          DatePicker(
            DateTime.now().subtract(const Duration(days: 3)),
            height: 90,
            width: 70,
            initialSelectedDate: DateTime.now(),
            selectionColor: AppColors.primaryColor,
            selectedTextColor: Colors.white,
            onDateChange: (date) {},
          ),
          TasksTabsBuilder(),
        ],
      ),
    );
  }
}
