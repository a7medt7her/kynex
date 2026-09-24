import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';

class OnboardIndicator extends StatelessWidget {
  const OnboardIndicator({
    super.key,
    required this.currentIndex,
    required this.length,
  });

  final int currentIndex;
  final int length;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Container(
          margin: REdgeInsets.symmetric(horizontal: 10),
          width: currentIndex == index ? 32.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.primary2
                : AppColors.black4,
            shape: currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
          ),
        );
      }),
    );
  }
}
