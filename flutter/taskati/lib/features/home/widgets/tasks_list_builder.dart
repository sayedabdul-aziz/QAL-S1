import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class TasksListBuilder extends StatelessWidget {
  const TasksListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => TaskCard(),
      separatorBuilder: (context, index) => const Gap(10),
      itemCount: 5,
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

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
            'Task : Title of task',
            style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Description for task  Description for task  Description for task ',
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
                '8:00 PM : 10:00 PM',
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
                  'Done',
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
