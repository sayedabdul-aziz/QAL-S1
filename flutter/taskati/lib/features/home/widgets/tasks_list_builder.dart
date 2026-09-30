import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local/hive_provider.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class TasksListBuilder extends StatelessWidget {
  const TasksListBuilder({super.key, required this.selectedDate});

  final String selectedDate;

  @override
  Widget build(BuildContext context) {
    //* use ValueListenableBuilder to listen to changes in the box
    return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable: HiveProvider.taskBox.listenable(),
      builder: (context, box, widget) {
        // fetch all tasks from box
        var tasks = box.values.toList();

        // filter tasks by selected date
        tasks = tasks.where((task) => task.date == selectedDate).toList();

        // display tasks in a list
        return ListView.separated(
          itemBuilder: (context, index) {
            return TaskCard(task: tasks[index]);
          },
          separatorBuilder: (context, index) => const Gap(10),
          itemCount: tasks.length,
        );
      },
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: .start,
        children: [
          Text(
            task.title ?? '',
            style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            task.description ?? '',
            style: TextStyles.caption1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(
                Icons.watch_later_rounded,
                color: AppColors.primaryColor100,
                size: 18,
              ),
              const Gap(8),
              Text(
                "${task.startTime ?? ''}-${task.endTime ?? ''}",
                style: TextStyles.caption2.copyWith(
                  color: AppColors.primaryColor100,
                ),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  task.isCompleted == true ? 'Done' : 'InProgress',
                  style: TextStyles.caption2.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
