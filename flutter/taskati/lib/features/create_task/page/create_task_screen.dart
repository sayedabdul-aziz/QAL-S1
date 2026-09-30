import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local/hive_provider.dart';
import 'package:taskati/core/widgets/custom_svg_image.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/core/widgets/my_scaffold.dart';
import 'package:taskati/features/create_task/widgets/date_time_field.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String? selectedDate;
  String? selectedStartTime;
  String? selectedEndTime;

  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        leading: Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CustomSvgImage(path: AppImages.backSvg, width: 30),
          ),
        ),
        title: const Text('Create Task'),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: formKey,
          child: Column(
            spacing: 32,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: titleController,
                title: 'Title',
                hintText: 'Enter Task Title',
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task title';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: descriptionController,
                title: 'Description',
                hintText: 'Enter Task Description',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task description';
                  }
                  return null;
                },
              ),
              DateTimeField(
                leading: AppImages.calendarSvg,
                title: 'Date',
                subtitle: selectedDate ?? 'Select Date',
                onTap: () async {
                  var date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 60)),
                  );

                  if (date != null) {
                    setState(() {
                      selectedDate = DateFormat('dd MMM, yyyy').format(date);
                    });
                  }
                },
                errorMsg: isClicked && selectedDate == null
                    ? 'Please select date'
                    : null,
              ),
              DateTimeField(
                leading: AppImages.timeSvg,
                title: 'Start Time',
                subtitle: selectedStartTime ?? 'Select Time',
                onTap: () async {
                  var time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      selectedStartTime = time.format(context);
                    });
                  }
                },
                errorMsg: isClicked && selectedStartTime == null
                    ? 'Please select start time'
                    : null,
              ),
              DateTimeField(
                leading: AppImages.timeSvg,
                title: 'End Time',
                subtitle: selectedEndTime ?? 'Select Time',
                onTap: () async {
                  var time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      selectedEndTime = time.format(context);
                    });
                  }
                },
                errorMsg: isClicked && selectedEndTime == null
                    ? 'Please select end time'
                    : null,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: MainButton(
            text: 'Create Task',
            onPressed: () async {
              setState(() {
                isClicked = true;
              });
              if (formKey.currentState!.validate()) {
                var key =
                    DateTime.now().millisecondsSinceEpoch.toString() +
                    titleController.text;
                var task = TaskModel(
                  id: key,
                  title: titleController.text,
                  description: descriptionController.text,
                  date: selectedDate,
                  startTime: selectedStartTime,
                  endTime: selectedEndTime,
                  isCompleted: false,
                );

                await HiveProvider.cacheTask(key, task);
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
