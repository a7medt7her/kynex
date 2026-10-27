import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/features/setup_profile/data/helper/fitness_calculations.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/features/setup_profile/data/enums/eunms.dart';
import 'package:kynex/features/setup_profile/data/model/cards_models.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/cards.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/setup_cubit/cubit/setup_cubit.dart';

class UserGoals extends StatelessWidget {
  const UserGoals({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Text(
              'Your Fitness Profile',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 24.sp,
                fontWeight: AppTextStyle.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Help us customize your experience by selecting your current level and primary goal.',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamliy2,
                color: AppColors.secondary,
                fontSize: 16.sp,
                fontWeight: AppTextStyle.regular,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            BlocSelector<SetupCubit, SetupState, Levels?>(
              selector: (state) => state.userSetup.levels,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Level',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20.sp,
                        fontWeight: AppTextStyle.semiBold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Cards(
                      text1: 'Beginner',
                      onTap: () {
                        context.read<SetupCubit>().saveLevels(
                          levels: Levels.beginner,
                        );
                      },
                      icon: state == Levels.beginner
                          ? AssetsIcon.activeBeginner
                          : AssetsIcon.beginner,

                      child: Text(
                        'Just starting out',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamliy2,
                          fontSize: 12.sp,
                          fontWeight: AppTextStyle.medium,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Cards(
                      text1: 'Intermediate',
                      onTap: () {
                        context.read<SetupCubit>().saveLevels(
                          levels: Levels.intermediate,
                        );
                      },
                      icon: state == Levels.intermediate
                          ? AssetsIcon.activeDomibble
                          : AssetsIcon.dumbbil,

                      child: Text(
                        'Familiar with training',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamliy2,
                          fontSize: 12.sp,
                          fontWeight: AppTextStyle.medium,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Cards(
                      text1: 'Advanced',
                      onTap: () {
                        context.read<SetupCubit>().saveLevels(
                          levels: Levels.advanced,
                        );
                      },
                      icon: state == Levels.advanced
                          ? AssetsIcon.activeAdvanced
                          : AssetsIcon.advanced,
                      child: Text(
                        'Experienced athlete',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamliy2,
                          fontSize: 12.sp,
                          fontWeight: AppTextStyle.medium,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 32.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Primary Goal',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20.sp,
                    fontWeight: AppTextStyle.semiBold,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 500.h,
                  width: double.infinity,
                  child: BlocSelector<SetupCubit, SetupState, FitnessGoal?>(
                    selector: (state) => state.userSetup.fitnessGoal,

                    builder: (context, state) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                        itemCount: 4,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final List<CardsModels> listData = [
                            CardsModels(
                              text: 'Lose Weight',
                              icon: state == FitnessGoal.weightLoss
                                  ? AssetsIcon.activeLoseWeight
                                  : AssetsIcon.loseWeight,
                            ),
                            CardsModels(
                              text: 'Build Muscle',
                              icon: state == FitnessGoal.muscleGain
                                  ? AssetsIcon.activeDomibble
                                  : AssetsIcon.dumbbil,
                            ),
                            CardsModels(
                              text: 'Endurance',
                              icon: state == FitnessGoal.endurance
                                  ? AssetsIcon.activeEndurance
                                  : AssetsIcon.endurance,
                            ),
                            CardsModels(
                              text: 'Flexibility',
                              icon: state == FitnessGoal.flexibility
                                  ? AssetsIcon.activeFlexibility
                                  : AssetsIcon.flexibility,
                            ),
                          ];
                          final data = listData[index];
                          final List<FitnessGoal> goals = [
                            FitnessGoal.weightLoss,
                            FitnessGoal.muscleGain,
                            FitnessGoal.endurance,
                            FitnessGoal.flexibility,
                          ];
                          final goalData = goals[index];

                          return Cards(
                            onTap: () {
                              context.read<SetupCubit>().saveFitnessGoal(
                                fitnessGoal: goalData,
                              );
                            },
                            height: 0,
                            text1: data.text,
                            icon: data.icon,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
