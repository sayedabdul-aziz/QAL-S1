import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.validator,
    this.controller,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      minLines: 1,
      decoration: InputDecoration(hintText: hintText),
      validator: validator,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}

//  list1 , list2

// list3 = [ if(condition)...list1 , list2 ]
