import 'package:flutter/material.dart';

import '../utils/AppColor.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  const CustomTextButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color,
      this.fontSize, this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(
      text,
      style: TextStyle(
        color: color ?? AppColors.kPrimary,
        fontSize: fontSize,
        fontFamily: fontFamily ,

      ),
    ));
  }
}
