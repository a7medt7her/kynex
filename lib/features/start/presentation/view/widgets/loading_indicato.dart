import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';

class LoadingIndicato extends StatelessWidget {
  const LoadingIndicato({super.key, required this.activeIndex});
  final int activeIndex;
  final List<List<double>> alphas = const [
    [1.0, 0.7, 0.4],
    [0.4, 1.0, 0.7],
    [0.7, 0.4, 1.0],
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceInOut,
          margin: REdgeInsets.symmetric(horizontal: 6),
          width: 6.w,
          height: 6.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(
              alpha: alphas[activeIndex][index],
            ),
          ),
        );
      }),
    );
  }
}
