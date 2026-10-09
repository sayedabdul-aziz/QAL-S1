import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/extensions.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/models/task_status_enum.dart';
import 'package:taskati/core/services/local/hive_provider.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/features/home/widgets/task_card_slidable.dart';

// (TASK box) => 1/2/3/4/5/6/7/8/9/10

class TasksListBuilder extends StatelessWidget {
  const TasksListBuilder({
    super.key,
    required this.selectedDate,
    required this.taskStatus,
  });

  final String selectedDate;
  final TaskStatusEnum taskStatus;

  @override
  Widget build(BuildContext context) {
    //* use ValueListenableBuilder to listen to changes in the box
    return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable: HiveProvider.taskBox.listenable(),
      builder: (context, box, widget) {
        // fetch all tasks from box
        var tasks = box.values.toList();

        List<TaskModel> selectedTasks = [];

        // filter tasks by selected date
        // tasks = tasks.where((task) => task.date == selectedDate).toList();
        for (var task in tasks) {
          if (task.date == selectedDate) {
            // filter tasks by taskStatus
            if (taskStatus == TaskStatusEnum.all) {
              selectedTasks.add(task);
            } else if (taskStatus == TaskStatusEnum.inProgress &&
                task.isCompleted == false) {
              selectedTasks.add(task);
            } else if (taskStatus == TaskStatusEnum.completed &&
                task.isCompleted == true) {
              selectedTasks.add(task);
            }
          }
        }

        if (selectedTasks.isEmpty) {
          return Column(
            children: [
              Lottie.asset(AppImages.emptyLottie, width: 300),
              const Gap(12),
              Text(
                'No tasks for today',
                style: TextStyles.body.copyWith(fontWeight: FontWeight.w500),
              ),
              const Gap(8),
              Text(
                'Add a task to get started',
                style: TextStyles.caption1.copyWith(
                  fontWeight: FontWeight.normal,
                  color: context.colorScheme.tertiary,
                ),
              ),
            ],
          );
        }

        // display tasks in a list
        return ListView.separated(
          itemBuilder: (context, index) {
            return TaskCardSlidable(taskModel: selectedTasks[index]);
          },
          separatorBuilder: (context, index) => const Gap(10),
          itemCount: selectedTasks.length,
        );
      },
    );
  }
}
