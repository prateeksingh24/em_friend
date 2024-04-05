import 'package:flutter/material.dart';

import '../utils/AppColor.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? btnColor;
  final Color? fontColor;
  final String? fontFamily;
  const PrimaryButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.height,
      this.width,
      this.fontSize,
      this.btnColor,
      this.fontColor,
      this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: btnColor ?? AppColors.kPrimary,
          borderRadius: BorderRadius.circular(23),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: fontColor ?? AppColors.kLightWhite,
            fontSize: fontSize ?? 20,
            fontWeight: FontWeight.w500,
          ),
        ),


      ),
    );
  }
}
