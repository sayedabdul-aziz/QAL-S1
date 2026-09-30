import 'package:flutter/material.dart';
import 'package:taskati/core/functions/naviagtions.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/widgets/my_scaffold.dart';
import 'package:taskati/features/create_task/page/create_task_screen.dart';
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
          TasksTabsBuilder(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          pushTo(context, CreateTaskScreen());
        },
      ),
    );
  }
}
