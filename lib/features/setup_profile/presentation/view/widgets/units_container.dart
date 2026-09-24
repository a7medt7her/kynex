import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';

class UnitsContainer extends StatelessWidget {
  const UnitsContainer({
    super.key,
    required this.unitName,
    this.onTap1,
    required this.whichUnit,
    this.onTap2,
    required this.unit1,
    required this.unit2,
    required this.controller,
  });
  final String unitName;
  final void Function()? onTap1;
  final void Function()? onTap2;
  final bool whichUnit;
  final String unit1;
  final String unit2;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              unitName,
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamliy2,
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: AppTextStyle.semiBold,
              ),
            ),
            Spacer(),
            Container(
              padding: REdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.black2,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onTap1,
                        child: Container(
                          padding: REdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: whichUnit
                                ? AppColors.black4
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              unit1,
                              style: TextStyle(
                                color: whichUnit
                                    ? AppColors.white
                                    : AppColors.secondary,
                                fontFamily: AppTextStyle.fontFamliy2,
                                fontSize: 12.sp,
                                fontWeight: AppTextStyle.medium,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      GestureDetector(
                        onTap: onTap2,
                        child: Container(
                          padding: REdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: !whichUnit
                                ? AppColors.black4
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              unit2,
                              style: TextStyle(
                                color: !whichUnit
                                    ? AppColors.white
                                    : AppColors.secondary,
                                fontFamily: AppTextStyle.fontFamliy2,
                                fontSize: 12.sp,
                                fontWeight: AppTextStyle.medium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: 316.w,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.black2,
              border: Border.all(color: AppColors.black5, width: 2.w),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 48.sp,
                fontWeight: AppTextStyle.bold,
              ),
              decoration: InputDecoration(
                suffixIconConstraints: BoxConstraints(minWidth: 40.w),
                suffixIcon: Padding(
                  padding: REdgeInsets.symmetric(vertical: 35, horizontal: 10),
                  child: Text(
                    whichUnit ? unit1 : unit2,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: AppTextStyle.semiBold,
                      fontFamily: AppTextStyle.fontFamliy2,
                      fontSize: 14.sp,
                    ),
                  ),
                ),

                fillColor: AppColors.black,
                filled: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
