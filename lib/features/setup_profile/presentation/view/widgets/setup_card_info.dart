import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/helper/svg_helper.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';

class SetupCardInfo extends StatelessWidget {
  const SetupCardInfo({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.child,
    this.subtitleColor,
  });
  final String icon;
  final String title;
  final String? subtitle;
  final Widget? child;
  final Color? subtitleColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.black7.withValues(alpha: 0.5),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.05),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              svgHelper(icon, 10.5.w, 10.5.h),
              SizedBox(width: 4.w),
              Text(
                title,
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamliy2,
                  color: AppColors.secondary,
                  fontSize: 12.sp,
                  fontWeight: AppTextStyle.medium,
                ),
              ),
            ],
          ),
          Row(
            children: [
              subtitle == null
                  ? SizedBox()
                  : Text(
                      subtitle!,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamliy2,
                        color: subtitleColor ?? AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: AppTextStyle.semiBold,
                      ),
                    ),
              SizedBox(width: 4.w),
              child ?? SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
