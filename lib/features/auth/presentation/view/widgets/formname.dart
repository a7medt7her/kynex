import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/widgets/coustom_textfiled.dart';

class FormName extends StatelessWidget {
  const FormName({
    super.key,
    required this.name,
    required this.controller,
    required this.hint,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });
  final String name;
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 14.sp,
            fontWeight: AppTextStyle.semiBold,
            fontFamily: AppTextStyle.fontFamliy2,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextFiled(
          validator: validator,
          prefixIcon: prefixIcon,
          hintText: hint,
          controller: controller,
          obscureText: obscureText,
          suffixIcon: suffixIcon,
        ),
      ],
    );
  }
}
