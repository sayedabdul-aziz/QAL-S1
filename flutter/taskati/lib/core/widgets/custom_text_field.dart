import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.title,
    required this.hintText,
    this.prefixIcon,
    this.validator,
    this.controller,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String? title;
  final String hintText;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        if (title != null) ...[
          Text(
            title ?? '',
            style: TextStyles.caption1.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.greyColor,
            ),
          ),
          const Gap(8),
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondaryColor,
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            minLines: 1,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              hintText: hintText,
            ),
            validator: validator,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ),
      ],
    );
  }
}

//  list1 , list2

// list3 = [ if(condition)...list1 , list2 ]
