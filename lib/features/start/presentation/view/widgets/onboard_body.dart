import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';

class OnboardBody extends StatelessWidget {
  const OnboardBody({
    super.key,
    required this.text1,
    required this.text2,
    required this.image,
  });
  final String text1;
  final String text2;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black3,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: 486.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,

                colors: [
                  Colors.transparent,
                  AppColors.babyBlue.withValues(alpha: 0.4),
                  AppColors.black2,
                ],
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 486.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,
                stops: [0.0, 0.5, 1.0],
                colors: [
                  Colors.transparent,
                  AppColors.black3.withValues(alpha: 0.4),
                  AppColors.black3,
                ],
              ),
            ),
          ),
          Positioned(
            left: 30.w,
            top: 500.h,
            right: 30.w,
            child: Column(
              children: [
                Text(
                  text1,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 32.sp,
                    fontWeight: AppTextStyle.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Text(
                  text2,
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 18.sp,
                    fontWeight: AppTextStyle.regular,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
