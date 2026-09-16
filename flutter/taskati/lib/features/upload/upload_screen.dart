import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/toast.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String imagePath = '';
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              // 1) no image, no name
              if (imagePath.isEmpty && controller.text.isEmpty) {
                showErrorDialog(
                  context,
                  'Please enter a name and select an image',
                );
              } else if (imagePath.isEmpty && controller.text.isNotEmpty) {
                showErrorDialog(context, 'Please select an image');
              } else if (imagePath.isNotEmpty && controller.text.isEmpty) {
                showErrorDialog(context, 'Please enter a name');
              } else {}
            },
            child: Text(
              'Done',
              style: TextStyles.body.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(60),
              if (imagePath.isNotEmpty)
                ClipOval(
                  child: Image.file(
                    File(imagePath),
                    height: 180,
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                )
              else
                ClipOval(
                  child: Image.asset(
                    AppImages.userEmpty,
                    height: 180,
                    color: AppColors.greyColor,
                  ),
                ),
              const Gap(32),
              MainButton(
                width: 250,
                text: 'Upload From Camera',
                onPressed: () {
                  pickImage(true);
                },
              ),
              const Gap(16),
              MainButton(
                width: 250,
                text: 'Upload From Gallery',
                onPressed: () {
                  pickImage(false);
                },
              ),
              const Gap(32),
              Divider(),
              const Gap(32),
              CustomTextField(
                controller: controller,
                hintText: 'Enter Your Name',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage(bool isCamera) async {
    final imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
      });
    }
  }
}
