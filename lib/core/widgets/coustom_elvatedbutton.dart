import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';

class CustomElvatedButton extends StatelessWidget {
  const CustomElvatedButton({
    super.key,
    required this.onPressed,
    required this.text,

    this.colorContainer,
    this.border,

    this.textColor,
    required this.fontSize,
    this.widget,
    this.sizedBoxWidth,
    this.borderRadius,
  });
  final VoidCallback onPressed;
  final String text;
  final Color? colorContainer;
  final BoxBorder? border;
  final Color? textColor;
  final double fontSize;
  final Widget? widget;
  final double? sizedBoxWidth;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 15.5),
        width: double.infinity,
        decoration: BoxDecoration(
          border: BoxBorder.all(width: 1.w, color: AppColors.primary),
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          color: colorContainer ?? AppColors.primary2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: AppTextStyle.semiBold,
                color: textColor ?? AppColors.white,
                fontSize: fontSize.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: sizedBoxWidth ?? 0),
            widget ?? SizedBox(),
          ],
        ),
      ),
    );
  }
}
