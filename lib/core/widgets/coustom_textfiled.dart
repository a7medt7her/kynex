import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    required this.controller,

    required this.obscureText,
    this.validator,

    this.readOnly,
  });
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextEditingController controller;

  final bool obscureText;
  final String? Function(String?)? validator;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: AppColors.secondary),
      validator: validator,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        suffixIcon: suffixIcon,

        prefixIcon: prefixIcon,

        prefixIconConstraints: BoxConstraints(
          minWidth: 20.w,
          minHeight: 20.h,
          maxWidth: 20.w,
          maxHeight: 20.h,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: AppTextStyle.light,
          color: AppColors.secondary,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
