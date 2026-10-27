import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/features/setup_profile/data/helper/convert_duration.dart';
import 'package:kynex/features/setup_profile/data/model/uer_setup_model.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/setup_card_info.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/setup_cubit/cubit/setup_cubit.dart';

class FinishSetupPage extends StatefulWidget {
  const FinishSetupPage({super.key});

  @override
  State<FinishSetupPage> createState() => _FinishSetupPageState();
}

class _FinishSetupPageState extends State<FinishSetupPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flipController;

  @override
  void initState() {
    super.initState();

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_flipController.isAnimating) return;

    if (_flipController.isCompleted) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SetupCubit>().state.userSetup;

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Review Profile',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 24.sp,
              fontWeight: AppTextStyle.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Let's verify your details before we start.",
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamliy2,
              color: AppColors.secondary,
              fontSize: 16.sp,
              fontWeight: AppTextStyle.regular,
            ),
          ),
          SizedBox(height: 32.h),
          AnimatedBuilder(
            animation: _flipController,
            builder: (context, child) {
              final angle = _flipController.value * math.pi;
              final showFront = _flipController.value < 0.5;

              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
                child: showFront
                    ? _buildFrontCard(cubit)
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(math.pi),
                        child: _buildBackCard(cubit),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFrontCard(UserSetupModel cubit) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.w, sigmaY: 5.h),
        child: Container(
          padding: REdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.08),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.05)),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2.w),
                    ),
                    child: Image.asset(Images.womanProfile, fit: BoxFit.cover),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    children: [
                      Text(
                        cubit.username ?? 'hi There',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20.sp,
                          fontWeight: AppTextStyle.semiBold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Ready to crush it",
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamliy2,
                          color: AppColors.primary2,
                          fontSize: 14.sp,
                          fontWeight: AppTextStyle.semiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  SetupCardInfo(
                    icon: AssetsIcon.loseWeight,
                    title: 'CURRENT WEIGHT',
                    subtitle: cubit.weight.toString(),
                    child: Text(
                      cubit.weightUnit?.name ?? 'NOT FOUNDED',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontFamily: AppTextStyle.fontFamliy2,
                        fontSize: 14.sp,
                        fontWeight: AppTextStyle.regular,
                      ),
                    ),
                  ),
                  Spacer(),
                  SetupCardInfo(
                    subtitleColor: AppColors.primary,
                    icon: AssetsIcon.goal,
                    title: 'GOAL WEIGHT',
                    subtitle: cubit.targetWeight.toString(),
                    child: Text(
                      cubit.targetWeightUnit?.name ?? 'NOT FOUNDED',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontFamily: AppTextStyle.fontFamliy2,
                        fontSize: 14.sp,
                        fontWeight: AppTextStyle.regular,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              SetupCardInfo(
                icon: AssetsIcon.dumbbil,
                title: 'PRIMARY FOCUS',
                subtitle: cubit.fitnessGoal?.name,
              ),
              SizedBox(height: 20.h),
              SetupCardInfo(
                icon: AssetsIcon.cOMMITMENT,
                title: 'COMMITMENT',
                child: Row(
                  children: [
                    Container(
                      padding: REdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(99999.r),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.primary.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        '${cubit.weekDay.length} Days/Week',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12.w,
                          fontFamily: AppTextStyle.fontFamliy2,
                          fontWeight: AppTextStyle.medium,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      padding: REdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.black8,
                        borderRadius: BorderRadius.circular(99999.r),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        '${convertDuration(cubit.exerciseDuration)} Min Sessions',
                        style: TextStyle(
                          color: AppColors.gray2,
                          fontSize: 12.w,
                          fontFamily: AppTextStyle.fontFamliy2,
                          fontWeight: AppTextStyle.medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26.h),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: _flipCard,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    padding: REdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.black.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'More Details',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 13.sp,
                            fontWeight: AppTextStyle.semiBold,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.primary,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackCard(UserSetupModel cubit) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.w, sigmaY: 5.h),
        child: Container(
          padding: REdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.08),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.05)),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2.w),
                    ),
                    child: Image.asset(Images.womanProfile, fit: BoxFit.cover),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    children: [
                      Text(
                        cubit.username ?? 'hi There',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20.sp,
                          fontWeight: AppTextStyle.semiBold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "No pain, no gain",
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamliy2,
                          color: AppColors.primary2,
                          fontSize: 14.sp,
                          fontWeight: AppTextStyle.semiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  SetupCardInfo(
                    icon: AssetsIcon.cOMMITMENT,
                    title: 'Age',
                    subtitle: cubit.age.toString(),
                    child: Text(
                      'Year',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontFamily: AppTextStyle.fontFamliy2,
                        fontSize: 14.sp,
                        fontWeight: AppTextStyle.regular,
                      ),
                    ),
                  ),
                  Spacer(),
                  SetupCardInfo(
                    subtitleColor: AppColors.primary,
                    icon: AssetsIcon.container,
                    title: 'Target Calories',
                    subtitle: cubit.targetCalories?.toStringAsFixed(2),
                    child: Text(
                      'Calories',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontFamily: AppTextStyle.fontFamliy2,
                        fontSize: 14.sp,
                        fontWeight: AppTextStyle.regular,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              SetupCardInfo(
                icon: AssetsIcon.endurance,
                title: 'activityLevel',
                subtitle: cubit.activityLevel?.name,
              ),
              SizedBox(height: 20.h),
              SetupCardInfo(
                icon: AssetsIcon.dumbbil,
                title: 'COMMITMENT',
                child: Row(
                  children: [
                    Container(
                      padding: REdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(99999.r),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.primary.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        '${cubit.levels}',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12.w,
                          fontFamily: AppTextStyle.fontFamliy2,
                          fontWeight: AppTextStyle.medium,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      padding: REdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.black8,
                        borderRadius: BorderRadius.circular(99999.r),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        '${cubit.exerciseLocation?.name} ',
                        style: TextStyle(
                          color: AppColors.gray2,
                          fontSize: 12.w,
                          fontFamily: AppTextStyle.fontFamliy2,
                          fontWeight: AppTextStyle.medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26.h),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: _flipCard,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    padding: REdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.black.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'More Details',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 13.sp,
                            fontWeight: AppTextStyle.semiBold,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.primary,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
