import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';

class LocationTrainingCard extends StatelessWidget {
  const LocationTrainingCard({
    super.key,

    required this.subtitle,
    required this.selected,
    this.onTap,
    required this.child,
    required this.needPadding,
  });
  final bool needPadding;
  final String subtitle;
  final bool selected;
  final void Function()? onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50.w, sigmaY: 0.h),
          child: Container(
            padding: REdgeInsets.symmetric(horizontal: 10, vertical: 16),
            decoration: BoxDecoration(
              gradient: selected
                  ? LinearGradient(
                      begin: AlignmentGeometry.topLeft,
                      end: AlignmentGeometry.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        AppColors.primary2.withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    )
                  : null,
              boxShadow: [
                selected
                    ? BoxShadow(
                        color: AppColors.primary2.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: Offset(0, 0),
                      )
                    : BoxShadow(),
              ],
              border: Border.all(
                color: selected
                    ? AppColors.primary2
                    : AppColors.white.withValues(alpha: 0.05),
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(14.r),
              color: selected
                  ? AppColors.primary2.withValues(alpha: 0.5)
                  : AppColors.black6.withValues(alpha: 0.6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: needPadding
                      ? REdgeInsets.symmetric(horizontal: 34)
                      : REdgeInsets.symmetric(horizontal: 0),
                  child: child,
                ),
                SizedBox(height: 14.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: selected ? AppColors.primary2 : AppColors.white,
                    fontSize: 14.sp,
                    fontWeight: AppTextStyle.regular,
                    fontFamily: AppTextStyle.fontFamliy2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
