import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/features/home/widgets/tasks_list_builder.dart';

class TasksTabsBuilder extends StatefulWidget {
  const TasksTabsBuilder({super.key});

  @override
  State<TasksTabsBuilder> createState() => _TasksTabsBuilderState();
}

class _TasksTabsBuilderState extends State<TasksTabsBuilder> {
  int currentIndex = 0;
  String selectedDate = DateFormat(
    'dd MMM, yyyy',
  ).format(DateTime.now()); // 2020
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Column(
          spacing: 20,
          children: [
            DatePicker(
              DateTime.now().subtract(const Duration(days: 3)),
              height: 90,
              width: 70,
              initialSelectedDate: DateTime.now(),
              selectionColor: AppColors.primaryColor,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                setState(() {
                  selectedDate = DateFormat('dd MMM, yyyy').format(date);
                });
              },
            ),
            TabBar(
              dividerHeight: 0,
              indicator: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorPadding: const EdgeInsets.all(0),
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 0,
              ),
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              tabs: [
                Tab(
                  child: CustomTab(label: 'All', isSelected: currentIndex == 0),
                ),
                Tab(
                  child: CustomTab(
                    label: 'In Progress',
                    isSelected: currentIndex == 1,
                  ),
                ),
                Tab(
                  child: CustomTab(
                    label: 'Completed',
                    isSelected: currentIndex == 2,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TasksListBuilder(selectedDate: selectedDate),
                  TasksListBuilder(selectedDate: selectedDate),
                  TasksListBuilder(selectedDate: selectedDate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CustomTab({super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyles.caption1.copyWith(
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
