import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.validator,
    this.controller,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final int maxLines;
  final bool readOnly;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly,
      minLines: 1,
      decoration: InputDecoration(suffixIcon: suffixIcon, hintText: hintText),
      validator: validator,
      onTap: onTap,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}

//  list1 , list2

// list3 = [ if(condition)...list1 , list2 ]
