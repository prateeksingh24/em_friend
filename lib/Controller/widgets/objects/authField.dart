import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/AppColor.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String icon;
  final Color iconColor;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const AuthField(
      {super.key,
        required this.controller,
        required this.icon,
        required this.iconColor,
        required this.hintText,
        this.keyboardType,
        this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.grey,
      controller: controller,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        fillColor: AppColors.kLightWhite2,
        filled: true,
        errorMaxLines: 3,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            decoration:
            BoxDecoration(shape: BoxShape.circle, color: iconColor),
            child: SvgPicture.asset(icon),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color:  AppColors.kPeriwinkle),
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:  AppColors.kPeriwinkle),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
