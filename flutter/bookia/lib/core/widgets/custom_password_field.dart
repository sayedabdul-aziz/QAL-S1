import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    super.key,
    required this.hintText,
    this.validator,
    this.controller,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIconConstraints: const BoxConstraints(maxWidth: 40),
        suffixIcon: Center(
          child: InkWell(
            onTap: () => setState(() {
              isObscure = !isObscure;
            }),
            child: CustomSvgImage(path: AppImages.eyeSvg),
          ),
        ),
      ),
      validator: widget.validator,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}

//  list1 , list2

// list3 = [ if(condition)...list1 , list2 ]
