import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/functions/extensions.dart';
import 'package:taskati/core/functions/naviagtions.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local/hive_provider.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/features/create_task/page/create_edit_task_screen.dart';

class TaskCardSlidable extends StatelessWidget {
  const TaskCardSlidable({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pushTo(context, CreateAndEditTaskScreen(task: taskModel)),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              HiveProvider.taskBox.delete(taskModel.id);
            },
          ),
          children: [
            SlidableAction(
              onPressed: (context) {
                HiveProvider.taskBox.delete(taskModel.id);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () async {
              var task = taskModel.copyWith(isCompleted: true);
              await HiveProvider.cacheTask(taskModel.id ?? '', task);
            },
          ),
          children: [
            SlidableAction(
              onPressed: (context) {
                pushTo(context, CreateAndEditTaskScreen(task: taskModel));
              },
              backgroundColor: context.theme.primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),

            SlidableAction(
              onPressed: (context) async {
                var task = taskModel.copyWith(isCompleted: true);
                await HiveProvider.cacheTask(taskModel.id ?? '', task);
              },
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.check,
              label: 'Complete',
            ),
          ],
        ),
        child: TaskCard(task: taskModel),
      ),
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
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: context.isDark
            ? []
            : [
                BoxShadow(
                  color: context.colorScheme.secondary,
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
                color: context.theme.hoverColor,
                size: 18,
              ),
              const Gap(8),
              Text(
                "${task.startTime ?? ''}-${task.endTime ?? ''}",
                style: TextStyles.caption2.copyWith(
                  color: context.theme.hoverColor,
                ),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: task.isCompleted == true
                      ? Colors.green.withValues(alpha: 0.1)
                      : context.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  task.isCompleted == true ? 'Done' : 'In Progress',
                  style: TextStyles.caption2.copyWith(
                    color: task.isCompleted == true
                        ? Colors.green
                        : context.theme.primaryColor,
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
