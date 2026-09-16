import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/styles/text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.title,
    required this.hintText,
    this.prefixIcon,
    this.validator,
    this.controller,
  });

  final TextEditingController? controller;
  final String? title;
  final String hintText;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        if (title != null) ...[
          Text(
            title ?? '',
            style: TextStyles.body.copyWith(fontWeight: FontWeight.w500),
          ),
          const Gap(8),
        ],
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hintText,
          ),
          validator: validator,

          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
        ),
      ],
    );
  }
}


//  list1 , list2

// list3 = [ if(condition)...list1 , list2 ]