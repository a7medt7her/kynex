import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/features/setup_profile/data/helper/fitness_calculations.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/features/setup_profile/data/helper/switchuntis.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/units_container.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/setup_cubit/cubit/setup_cubit.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/units_cubit/cubit/units_cubit.dart';

class UserBody extends StatefulWidget {
  const UserBody({super.key, required this.userBodyFormKey});

  final GlobalKey<FormState> userBodyFormKey;

  @override
  State<UserBody> createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final targetWeightController = TextEditingController();
  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    targetWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UnitsCubit(),

      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: widget.userBodyFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Body Profile',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24.sp,
                  fontWeight: AppTextStyle.bold,
                ),
              ),

              Text(
                'Tell us about yourself so we can calibrate your fitness journey.',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamliy2,
                  color: AppColors.secondary,
                  fontSize: 16.sp,
                  fontWeight: AppTextStyle.regular,
                ),
                maxLines: 2,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: REdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: 0.05),
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                      color: AppColors.black6.withValues(alpha: 0.6),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Age',
                              style: TextStyle(
                                fontFamily: AppTextStyle.fontFamliy2,
                                color: AppColors.white,
                                fontSize: 14.sp,
                                fontWeight: AppTextStyle.semiBold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Years',
                              style: TextStyle(
                                fontFamily: AppTextStyle.fontFamliy2,
                                color: AppColors.secondary,
                                fontSize: 12.sp,
                                fontWeight: AppTextStyle.medium,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        Container(
                          width: 316.w,
                          height: 77.h,
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                width: 1.w,
                                color: AppColors.primary2.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: const [0.0, 0.5, 1.0],
                              colors: [
                                AppColors.primary2.withValues(alpha: 0.1),
                                AppColors.primary2.withValues(alpha: 0.05),
                                AppColors.primary2.withValues(alpha: 0.03),
                              ],
                            ),
                          ),
                          child: BlocSelector<SetupCubit, SetupState, int?>(
                            selector: (state) => state.userSetup.age,
                            builder: (context, state) {
                              final selectedAge = state ?? 18;
                              return PageView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: PageController(
                                  viewportFraction: 0.3.w,
                                  initialPage: selectedAge - 18,
                                ),
                                itemCount: 63,

                                onPageChanged: (index) {
                                  final age = index + 18;
                                  context.read<SetupCubit>().saveAge(age: age);
                                },

                                itemBuilder: (context, index) {
                                  final age = index + 18;

                                  return Center(
                                    child: AnimatedOpacity(
                                      opacity: age == selectedAge ? 1 : 0.1,
                                      curve: Curves.easeInOutSine,
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      child: Text(
                                        '$age',
                                        style: TextStyle(
                                          fontWeight: AppTextStyle.bold,
                                          fontSize: 48.sp,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              Container(
                padding: REdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.05),
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.black6.withValues(alpha: 0.6),
                ),

                child: BlocBuilder<UnitsCubit, UnitsState>(
                  builder: (context, state) {
                    if (context.read<SetupCubit>().state.userSetup.height !=
                        null) {
                      heightController.text = context
                          .read<SetupCubit>()
                          .state
                          .userSetup
                          .height
                          .toString();
                    }
                    if (context.read<SetupCubit>().state.userSetup.weight !=
                        null) {
                      weightController.text = context
                          .read<SetupCubit>()
                          .state
                          .userSetup
                          .weight
                          .toString();
                    }
                    if (context
                            .read<SetupCubit>()
                            .state
                            .userSetup
                            .targetWeight !=
                        null) {
                      targetWeightController.text = context
                          .read<SetupCubit>()
                          .state
                          .userSetup
                          .targetWeight
                          .toString();
                    }
                    final cubit = context.read<UnitsCubit>();

                    return UnitsContainer(
                      unitName: 'Height',

                      whichUnit: cubit.heightUnit == HeightUnit.cm,

                      unit1: 'cm',
                      unit2: 'ft',

                      controller: heightController,
                      onChanged: (value) {
                        final height = num.tryParse(value);

                        if (height == null) return;
                        context.read<SetupCubit>().saveHeight(
                          height: height,
                          heightUnit: cubit.heightUnit,
                        );
                      },
                      onTap1: () {
                        switchUnits(
                          selectedUnit: HeightUnit.cm,
                          heightUnit: cubit.heightUnits,
                          unit: cubit.heightUnit == HeightUnit.cm,
                          convertHeight2: cubit.convertedHeight,
                          controllerText: heightController,
                        );
                      },

                      onTap2: () {
                        switchUnits(
                          selectedUnit: HeightUnit.ft,
                          heightUnit: cubit.heightUnits,
                          unit: cubit.heightUnit == HeightUnit.ft,
                          convertHeight2: cubit.convertedHeight,
                          controllerText: heightController,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.05),
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.black6.withValues(alpha: 0.6),
                ),
                child: BlocBuilder<UnitsCubit, UnitsState>(
                  builder: (context, state) {
                    final cubit = context.read<UnitsCubit>();
                    return UnitsContainer(
                      unitName: 'Weight',
                      whichUnit: cubit.weightUnit == WeightUnit.kg,
                      unit1: 'kg',
                      unit2: 'lbs',
                      controller: weightController,
                      onChanged: (value) {
                        final weight = num.tryParse(value);

                        if (weight == null) return;
                        context.read<SetupCubit>().saveWeight(
                          weight: weight,
                          weightUnit: cubit.weightUnit,
                        );
                      },
                      onTap1: () {
                        switchWeight(
                          selectedUnit: WeightUnit.kg,
                          weightUnit: cubit.wightUnit,
                          unit: cubit.weightUnit == WeightUnit.kg,
                          convertWeight2: cubit.convertedWight,
                          controllerText: weightController,
                        );
                      },
                      onTap2: () {
                        switchWeight(
                          selectedUnit: WeightUnit.lb,
                          weightUnit: cubit.wightUnit,
                          unit: cubit.weightUnit == WeightUnit.lb,
                          convertWeight2: cubit.convertedWight,
                          controllerText: weightController,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.05),
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.black6.withValues(alpha: 0.6),
                ),
                child: BlocBuilder<UnitsCubit, UnitsState>(
                  builder: (context, state) {
                    final cubit = context.read<UnitsCubit>();

                    return UnitsContainer(
                      unitName: 'Target Weight',

                      whichUnit: cubit.targetWeight == WeightUnit.kg,

                      unit1: 'kg',
                      unit2: 'lbs',

                      controller: targetWeightController,
                      onChanged: (value) {
                        final targetWeight = num.tryParse(value);

                        if (targetWeight == null) return;
                        context.read<SetupCubit>().saveTargetWeight(
                          targetWeight: targetWeight,
                          targetWeightUnit: cubit.targetWeight,
                        );
                      },
                      onTap1: () {
                        switchWeight(
                          selectedUnit: WeightUnit.kg,
                          weightUnit: cubit.targetWightUnit,
                          unit: cubit.targetWeight == WeightUnit.kg,
                          convertWeight2: cubit.convertedTargetWight,
                          controllerText: targetWeightController,
                        );
                      },

                      onTap2: () {
                        switchWeight(
                          selectedUnit: WeightUnit.lb,
                          weightUnit: cubit.targetWightUnit,
                          unit: cubit.targetWeight == WeightUnit.lb,
                          convertWeight2: cubit.convertedTargetWight,
                          controllerText: targetWeightController,
                        );
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
