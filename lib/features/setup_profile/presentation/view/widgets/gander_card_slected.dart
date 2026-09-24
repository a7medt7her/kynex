import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/circle_gandr.dart';

class GanderCardSelected extends StatelessWidget {
  const GanderCardSelected({
    super.key,
    required this.ganderTyp,
    required this.image,
  });
  final String ganderTyp;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(14.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.w, sigmaY: 12.h),
        child: Container(
          padding: REdgeInsets.symmetric(horizontal: 126, vertical: 24),
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.primary2.withValues(alpha: 0.1),
                blurRadius: 20,
                spreadRadius: 0,
                offset: Offset(0, 0),
              ),
            ],
            border: Border.all(color: AppColors.primary2, width: 1.w),
            borderRadius: BorderRadius.circular(14.r),
            color: AppColors.primary2.withValues(alpha: 0.5),
            gradient: LinearGradient(
              begin: AlignmentGeometry.topLeft,
              end: AlignmentGeometry.bottomRight,
              stops: [0.0, 1.0],
              colors: [
                AppColors.primary2.withValues(alpha: 0.1),
                Colors.transparent,
              ],
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 220.w,
                child: Container(
                  padding: REdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary2,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: AppColors.primaryDark,
                    size: 10.w,
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    CircleGander(image: image, padding: 27),
                    SizedBox(height: 16.h),
                    Text(
                      ganderTyp,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20.sp,
                        fontWeight: AppTextStyle.semiBold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
