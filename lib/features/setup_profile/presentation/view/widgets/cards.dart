import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/circle_gandr.dart';

class Cards extends StatelessWidget {
  const Cards({
    super.key,
    required this.text1,
    required this.icon,
    this.height,
    this.child,
    this.onTap,
  });
  final String text1;
  final String icon;
  final double? height;
  final Widget? child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 17),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.black6.withValues(alpha: 0.6),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.05),
            width: 2.w,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: CircleGander(padding: 14, image: icon),
            ),
            SizedBox(height: 12.h),
            Text(
              text1,
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamliy2,
                fontSize: 14.sp,
                fontWeight: AppTextStyle.semiBold,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: height ?? 4.h),
            child ?? SizedBox(),
          ],
        ),
      ),
    );
  }
}
