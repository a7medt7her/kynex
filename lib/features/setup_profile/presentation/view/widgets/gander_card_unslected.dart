import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/circle_gandr.dart';

class GanderCardUnselected extends StatelessWidget {
  const GanderCardUnselected({
    super.key,
    required this.ganderTyp,
    required this.image,
  });
  final String ganderTyp;
  final String image;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 12.h),
        child: Container(
          padding: REdgeInsets.symmetric(horizontal: 126, vertical: 24),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.white.withValues(alpha: 0.05),
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(14.r),
            color: AppColors.white.withValues(alpha: 0.04),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 220.w,
                child: Container(
                  padding: REdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.black2,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: AppColors.white, size: 10.w),
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
