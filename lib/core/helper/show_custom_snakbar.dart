import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';

enum SnackBarState { success, fail, warning, info }

void showSnackBar(
  context, {
  required String text,
  required SnackBarState state,
}) {
  IconData icon;
  Color color;
  switch (state) {
    case SnackBarState.success:
      color = AppColors.primaryDark;
      icon = Icons.check_circle;
    case SnackBarState.fail:
      color = AppColors.error;
      icon = Icons.error;
    case SnackBarState.warning:
      color = AppColors.error;
      icon = Icons.warning;
    case SnackBarState.info:
      color = AppColors.gray2;
      icon = Icons.info;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Row(
        children: [
          Icon(icon, color: AppColors.white),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(text, style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    ),
  );
}
