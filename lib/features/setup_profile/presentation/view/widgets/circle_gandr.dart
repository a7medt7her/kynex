import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/helper/svg_helper.dart';
import 'package:kynex/core/unitles/app_color.dart';

class CircleGander extends StatelessWidget {
  const CircleGander({super.key, required this.padding, required this.image});
  final double padding;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.black2,
      ),
      child: svgHelper(image, 16.w, 40.h),
    );
  }
}
