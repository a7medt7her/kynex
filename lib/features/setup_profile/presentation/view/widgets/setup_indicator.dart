import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';

class SetupIndicator extends StatelessWidget {
  const SetupIndicator({super.key, required this.currentPage});
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return AnimatedContainer(
          margin: REdgeInsets.symmetric(horizontal: 8),
          width: 32.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: currentPage == index ? AppColors.primary2 : AppColors.black5,
            borderRadius: BorderRadius.circular(999.r),
          ),
          duration: const Duration(milliseconds: 500),
        );
      }),
    );
  }
}
