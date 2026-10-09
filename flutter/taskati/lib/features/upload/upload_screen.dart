import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/extensions.dart';
import 'package:taskati/core/functions/naviagtions.dart';
import 'package:taskati/core/functions/toast.dart';
import 'package:taskati/core/services/local/hive_provider.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/core/widgets/my_scaffold.dart';
import 'package:taskati/core/widgets/secondary_button.dart';
import 'package:taskati/features/home/page/home_screen.dart';

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
    return MyScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Complete Your Profile"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(32),
                  _buildProfileImage(),

                  const Gap(32),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('Your Name', style: TextStyles.caption1),
                  ),
                  const Gap(16),
                  CustomTextField(
                    controller: controller,
                    hintText: 'Enter Your Name',
                  ),
                  const Gap(32),
                ],
              ),
            ),
          ),

          MainButton(
            text: "Let’s Start !",
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
              } else {
                HiveProvider.cacheUserData(
                  name: controller.text,
                  imagePath: imagePath,
                );
                pushReplacement(context, HomeScreen());
              }
            },
          ),
        ],
      ),
    );
  }

  Column _buildProfileImage() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Profile Image', style: TextStyles.caption1),
        ),
        const Gap(16),
        if (imagePath.isNotEmpty)
          Stack(
            children: [
              ClipOval(
                child: Image.file(
                  File(imagePath),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),

              // delete icon
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      imagePath = '';
                    });
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: context.theme.colorScheme.inversePrimary,
                    child: Icon(
                      Icons.delete,
                      color: context.theme.colorScheme.error,
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          ClipOval(
            child: Image.asset(
              AppImages.userEmpty,
              height: 180,
              color: context.colorScheme.secondary,
            ),
          ),
        const Gap(32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SecondaryButton(
              width: 120,
              text: 'From Camera',
              onPressed: () {
                pickImage(true);
              },
            ),
            const Gap(12),
            SecondaryButton(
              width: 120,
              text: 'From Gallery',
              onPressed: () {
                pickImage(false);
              },
            ),
          ],
        ),
      ],
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
