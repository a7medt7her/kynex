import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/features/setup_profile/data/helper/fitness_calculations.dart';
import 'package:kynex/core/helper/svg_helper.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/features/setup_profile/data/helper/activity_levels_info_data.dart';
import 'package:kynex/features/setup_profile/data/enums/eunms.dart';
import 'package:kynex/features/setup_profile/data/helper/exercise_info_data.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/location_training_card.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/exercise_cubit/cubit/exercise_info_page_cubit.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/setup_cubit/cubit/setup_cubit.dart';

class ExerciseInfo extends StatelessWidget {
  const ExerciseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseInfoPageCubit(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.h),
            Text(
              'Workout Preferences',
              style: TextStyle(
                fontSize: 24.sp,
                color: AppColors.white,
                fontWeight: AppTextStyle.bold,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Customize your training environment and schedule.',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.secondary,
                fontWeight: AppTextStyle.regular,
                fontFamily: AppTextStyle.fontFamliy2,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              'Preferred Location',
              style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.white,
                fontWeight: AppTextStyle.semiBold,
              ),
            ),
            SizedBox(height: 16.h),
            BlocSelector<SetupCubit, SetupState, ExerciseLocation?>(
              selector: (state) => state.userSetup.exerciseLocation,
              builder: (context, state) {
                final bool home = state == ExerciseLocation.home;
                final bool gym = state == ExerciseLocation.gym;
                final bool outdoor = state == ExerciseLocation.outdoor;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LocationTrainingCard(
                      onTap: () {
                        context.read<SetupCubit>().saveExerciseLocation(
                          exerciseLocation: ExerciseLocation.home,
                        );
                      },

                      subtitle: 'Home',
                      selected: home,
                      needPadding: true,
                      child: svgHelper(
                        home ? AssetsIcon.activeHome : AssetsIcon.home,
                        21.33.w,
                        24.h,
                      ),
                    ),
                    LocationTrainingCard(
                      needPadding: true,
                      onTap: () {
                        context.read<SetupCubit>().saveExerciseLocation(
                          exerciseLocation: ExerciseLocation.gym,
                        );
                      },

                      subtitle: 'Gym',
                      selected: gym,
                      child: svgHelper(
                        gym ? AssetsIcon.activeDomibble : AssetsIcon.dumbbil,
                        21.33.w,
                        24.h,
                      ),
                    ),
                    LocationTrainingCard(
                      needPadding: true,
                      onTap: () {
                        context.read<SetupCubit>().saveExerciseLocation(
                          exerciseLocation: ExerciseLocation.outdoor,
                        );
                      },

                      subtitle: 'Outdoor',
                      selected: outdoor,
                      child: svgHelper(
                        outdoor ? AssetsIcon.activeOutdoor : AssetsIcon.outdoor,
                        21.33.w,
                        24.h,
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                Text(
                  'Training Days',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: AppTextStyle.semiBold,
                    color: AppColors.white,
                  ),
                ),
                Spacer(),
                Text(
                  'Select at least 3',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: AppTextStyle.medium,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            BlocBuilder<ExerciseInfoPageCubit, ExerciseInfoPageState>(
              builder: (context, state) {
                return Row(
                  children: WeekDay.values.map((day) {
                    final isSelected;
                    if (context
                        .read<SetupCubit>()
                        .state
                        .userSetup
                        .weekDay
                        .isEmpty) {
                      isSelected = state.selectedDays.contains(day);
                    } else {
                      isSelected = context
                          .read<SetupCubit>()
                          .state
                          .userSetup
                          .weekDay
                          .contains(day);
                    }

                    return GestureDetector(
                      onTap: () {
                        final updatedDays = context
                            .read<ExerciseInfoPageCubit>()
                            .toggleDay(day);

                        context.read<SetupCubit>().saveWeekDay(
                          weekDay: updatedDays,
                        );
                      },
                      child: Container(
                        padding: REdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.r,
                            color: AppColors.white.withValues(alpha: 0.05),
                          ),
                          shape: BoxShape.circle,
                          color: isSelected
                              ? AppColors.primary2
                              : AppColors.black6.withValues(alpha: 0.6),
                        ),
                        child: Center(
                          child: Text(
                            day.name.toUpperCase(),
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.primaryDark
                                  : AppColors.white,
                              fontSize: 14.sp,
                              fontWeight: AppTextStyle.semiBold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 32.h),
            Text(
              'Avg. Duration',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20.sp,
                fontWeight: AppTextStyle.semiBold,
              ),
            ),
            SizedBox(height: 16.h),
            BlocSelector<SetupCubit, SetupState, ExerciseDuration?>(
              selector: (state) => state.userSetup.exerciseDuration,
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 550.h,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1,
                        ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      var data = dataDuration[index];

                      return LocationTrainingCard(
                        onTap: () {
                          context.read<SetupCubit>().saveExerciseDuration(
                            exerciseDuration: data.d,
                          );
                        },
                        subtitle: data.subTitle,
                        selected: state == data.d,
                        needPadding: false,
                        child: Text(
                          data.title,
                          style: TextStyle(
                            fontWeight: AppTextStyle.semiBold,
                            fontSize: 20.sp,
                            color: AppColors.white,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 32.h),
            Text(
              'ActivityLevel',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20.sp,
                fontWeight: AppTextStyle.semiBold,
              ),
            ),
            SizedBox(height: 16.h),
            BlocSelector<SetupCubit, SetupState, ActivityLevel?>(
              selector: (state) => state.userSetup.activityLevel,
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 800.h,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      var data = activityLevels[index];
                      return LocationTrainingCard(
                        onTap: () {
                          context.read<SetupCubit>().saveActivityLevel(
                            activityLevel: data.a,
                          );
                        },
                        subtitle: data.subTitle,
                        selected: state == data.a,
                        needPadding: false,
                        child: Text(
                          data.title,
                          style: TextStyle(
                            fontWeight: AppTextStyle.semiBold,
                            fontSize: 16.sp,
                            color: AppColors.white,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
