import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/helper/svg_helper.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/features/setup_profile/data/activity_levels_info_data.dart';
import 'package:kynex/features/setup_profile/data/enums/eunms.dart';
import 'package:kynex/features/setup_profile/data/exercise_info_data.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/location_training_card.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/exercise_cubit/cubit/exercise_info_page_cubit.dart';

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
            BlocBuilder<ExerciseInfoPageCubit, ExerciseInfoPageState>(
              builder: (context, state) {
                final cubit = context.read<ExerciseInfoPageCubit>();
                final bool home = state.location == ExerciseLocation.home;
                final bool gym = state.location == ExerciseLocation.gym;
                final bool outdoor = state.location == ExerciseLocation.outdoor;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LocationTrainingCard(
                      onTap: () {
                        cubit.selectLocation(ExerciseLocation.home);
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
                        cubit.selectLocation(ExerciseLocation.gym);
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
                        cubit.selectLocation(ExerciseLocation.outdoor);
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
                    final isSelected = state.selectedDays.contains(day);

                    return GestureDetector(
                      onTap: () {
                        context.read<ExerciseInfoPageCubit>().toggleDay(day);
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
            BlocBuilder<ExerciseInfoPageCubit, ExerciseInfoPageState>(
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
                      var cubit = context.read<ExerciseInfoPageCubit>();
                      return LocationTrainingCard(
                        onTap: () => cubit.selectDuration(data.d),
                        subtitle: data.subTitle,
                        selected: state.duration == data.d,
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
            BlocBuilder<ExerciseInfoPageCubit, ExerciseInfoPageState>(
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
                      var cubit = context.read<ExerciseInfoPageCubit>();
                      return LocationTrainingCard(
                        onTap: () => cubit.selectCurrentActivity(data.a),
                        subtitle: data.subTitle,
                        selected: state.currentActivityLevel == data.a,
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
