import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_toast.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/core/widgets/coustom_elvatedbutton.dart';
import 'package:kynex/core/widgets/custom_progress_indicator.dart';
import 'package:kynex/features/home/home_view.dart';
import 'package:kynex/features/setup_profile/data/data_sources/user_data_sources.dart';
import 'package:kynex/features/setup_profile/data/helper/fitness_calculations.dart';
import 'package:kynex/features/setup_profile/data/repo/user_setup_repository.dart';
import 'package:kynex/features/setup_profile/presentation/view/exercise_info.dart';
import 'package:kynex/features/setup_profile/presentation/view/finish_setup_page.dart';
import 'package:kynex/features/setup_profile/presentation/view/gander.dart';
import 'package:kynex/features/setup_profile/presentation/view/user_body.dart';
import 'package:kynex/features/setup_profile/presentation/view/user_goals.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/setup_indicator.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/setup_cubit/cubit/setup_cubit.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/setup_indicator/cubit/setup_indicator_cubit.dart';

class Setup extends StatefulWidget {
  const Setup({super.key, this.pageComplete});
  final int? pageComplete;

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  late final PageController pageController;

  final GlobalKey<FormState> userBodyPageFormKey = GlobalKey<FormState>();

  late final List<Widget> pages = [
    Gander(),
    UserBody(userBodyFormKey: userBodyPageFormKey),
    UserGoals(),
    ExerciseInfo(),
    FinishSetupPage(),
  ];
  @override
  void initState() {
    super.initState();

    final initialPage = (widget.pageComplete ?? 0).clamp(0, 4);

    pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SetupCubit(
            userSetupRepository: UserSetupRepository(
              userDataSources: UserDataSources(),
            ),
          )..getUserSetupData(),
        ),
        BlocProvider(
          create: (context) =>
              SetupIndicatorCubit()..currentPage(widget.pageComplete ?? 0),
        ),
      ],
      child: BlocListener<SetupCubit, SetupState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == SetupStatus.failure) {
            AppToast.showFailure(
              context: context,
              title: 'Request Failed',
              message:
                  state.errorMessage ??
                  'Something went wrong. Please try again.',
            );

            return;
          }
        },
        child: BlocSelector<SetupCubit, SetupState, SetupStatus>(
          selector: (state) {
            return state.status;
          },
          builder: (context, state) {
            return state == SetupStatus.dataLoading
                ? CustomProgressIndicator()
                : Scaffold(
                    body: Stack(
                      fit: StackFit.expand,
                      children: [
                        BlocBuilder<SetupIndicatorCubit, int>(
                          builder: (context, state) {
                            return state == 4
                                ? Image.asset(
                                    Images.finishSetupImageBackGround,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox();
                          },
                        ),

                        Padding(
                          padding: REdgeInsets.symmetric(horizontal: 20),
                          child: BlocBuilder<SetupIndicatorCubit, int>(
                            builder: (context, pageNumber) {
                              final indicatorCubit = context
                                  .read<SetupIndicatorCubit>();

                              return Column(
                                children: [
                                  SizedBox(height: 20.h),

                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: pageNumber == 0
                                            ? null
                                            : () {
                                                pageController.previousPage(
                                                  duration: const Duration(
                                                    milliseconds: 500,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                        icon: const Icon(
                                          Icons.arrow_back_ios_new,
                                          color: AppColors.white,
                                        ),
                                      ),

                                      SizedBox(width: 20.w),

                                      SetupIndicator(
                                        currentPage: pageNumber,
                                        numberOfPages: pages.length,
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10.h),

                                  Expanded(
                                    child: PageView.builder(
                                      controller: pageController,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: pages.length,
                                      onPageChanged: (value) {
                                        indicatorCubit.currentPage(value);
                                      },
                                      itemBuilder: (context, index) {
                                        return pages[index];
                                      },
                                    ),
                                  ),

                                  BlocBuilder<SetupCubit, SetupState>(
                                    builder: (context, state) {
                                      final isLoading =
                                          state.status == SetupStatus.loading;

                                      return isLoading
                                          ? CustomProgressIndicator()
                                          : CustomElvatedButton(
                                              borderRadius: pageNumber == 4
                                                  ? 99999.r
                                                  : 15,
                                              onPressed: () async {
                                                final setupCubit = context
                                                    .read<SetupCubit>();

                                                final userSetup =
                                                    state.userSetup;

                                                switch (pageNumber) {
                                                  case 0:
                                                    final gender =
                                                        userSetup.gender;

                                                    if (gender == null) {
                                                      AppToast.showFailure(
                                                        context: context,
                                                        title: 'Request Failed',
                                                        message:
                                                            'Please select your gender.',
                                                      );
                                                      return;
                                                    } else {
                                                      await setupCubit
                                                          .submitGender(
                                                            gender: gender,
                                                            currantPage:
                                                                pageNumber + 1,
                                                          );
                                                      AppToast.showFailure(
                                                        context: context,
                                                        title: 'Request Failed',
                                                        message:
                                                            'Please select your gender.',
                                                      );
                                                      pageController.nextPage(
                                                        duration:
                                                            const Duration(
                                                              milliseconds: 500,
                                                            ),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }

                                                    return;

                                                  case 1:
                                                    final isValid =
                                                        userBodyPageFormKey
                                                            .currentState
                                                            ?.validate() ??
                                                        false;

                                                    if (!isValid) {
                                                      AppToast.showFailure(
                                                        context: context,
                                                        title: 'Request Failed',
                                                        message:
                                                            'Please enter valid body information.',
                                                      );
                                                      return;
                                                    }

                                                    if (userSetup.height ==
                                                            null ||
                                                        userSetup.weight ==
                                                            null ||
                                                        userSetup
                                                                .targetWeight ==
                                                            null ||
                                                        userSetup.heightUnit ==
                                                            null ||
                                                        userSetup.weightUnit ==
                                                            null ||
                                                        userSetup.age! <= 0) {
                                                      AppToast.showFailure(
                                                        context: context,
                                                        title: 'Request Failed',
                                                        message:
                                                            'Please complete all body information.',
                                                      );
                                                      return;
                                                    } else {
                                                      await setupCubit.submitBodyData(
                                                        height:
                                                            userSetup.height!,
                                                        weight:
                                                            userSetup.weight!,
                                                        targetWeight: userSetup
                                                            .targetWeight!,
                                                        heightUnit: userSetup
                                                            .heightUnit!,
                                                        weightUnit: userSetup
                                                            .weightUnit!,
                                                        tWeightUnit: userSetup
                                                            .targetWeightUnit!,
                                                        age: userSetup.age!,
                                                        pageComplete:
                                                            pageNumber + 1,
                                                      );

                                                      AppToast.showSuccess(
                                                        context: context,
                                                        title: 'saved',
                                                        message:
                                                            state
                                                                .successMessage ??
                                                            'data saved successful',
                                                      );

                                                      pageController.nextPage(
                                                        duration:
                                                            const Duration(
                                                              milliseconds: 500,
                                                            ),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }

                                                    return;

                                                  case 2:
                                                    final levels =
                                                        userSetup.levels;
                                                    final fitnessGoal =
                                                        userSetup.fitnessGoal;

                                                    if (levels == null ||
                                                        fitnessGoal == null) {
                                                      AppToast.showFailure(
                                                        context: context,
                                                        title: 'Request Failed',
                                                        message:
                                                            'Please select your fitness goal and level.',
                                                      );
                                                      return;
                                                    } else {
                                                      await setupCubit
                                                          .submitGoal(
                                                            levels: levels,
                                                            fitnessGoal:
                                                                fitnessGoal,
                                                            pageComplete:
                                                                pageNumber + 1,
                                                          );
                                                      AppToast.showSuccess(
                                                        context: context,
                                                        title: 'saved',
                                                        message: state
                                                            .successMessage!,
                                                      );

                                                      pageController.nextPage(
                                                        duration:
                                                            const Duration(
                                                              milliseconds: 500,
                                                            ),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }

                                                    return;

                                                  case 3:
                                                    final activityLevel =
                                                        userSetup.activityLevel;

                                                    final exerciseLocation =
                                                        userSetup
                                                            .exerciseLocation;

                                                    final exerciseDuration =
                                                        userSetup
                                                            .exerciseDuration;

                                                    final weekDay =
                                                        userSetup.weekDay;

                                                    if (activityLevel == null ||
                                                        exerciseLocation ==
                                                            null ||
                                                        exerciseDuration ==
                                                            null ||
                                                        weekDay.length < 3) {
                                                      AppToast.showFailure(
                                                        context: context,
                                                        title: 'Request Failed',
                                                        message:
                                                            'Please complete all exercise information and select at least two days.',
                                                      );
                                                      return;
                                                    } else {
                                                      await setupCubit
                                                          .submitExerciseInfo(
                                                            activityLevel:
                                                                activityLevel,
                                                            exerciseLocation:
                                                                exerciseLocation,
                                                            exerciseDuration:
                                                                exerciseDuration,
                                                            weekDay: weekDay,
                                                            pageComplete:
                                                                pageNumber + 1,
                                                          );
                                                      await setupCubit.submitExtraUserData(
                                                        bmi: calculateBmi(
                                                          weight: state
                                                              .userSetup
                                                              .weight!,
                                                          weightUnit: state
                                                              .userSetup
                                                              .weightUnit!,
                                                          height: state
                                                              .userSetup
                                                              .height!,
                                                          heightUnit: state
                                                              .userSetup
                                                              .heightUnit!,
                                                        ),
                                                        targetBmi: calculateTargetBmi(
                                                          targetWeight: state
                                                              .userSetup
                                                              .targetWeight!,
                                                          targetWeightUnit: state
                                                              .userSetup
                                                              .targetWeightUnit!,
                                                          height: state
                                                              .userSetup
                                                              .height!,
                                                          heightUnit: state
                                                              .userSetup
                                                              .heightUnit!,
                                                        ),
                                                        bmr: calculateBmr(
                                                          weight: state
                                                              .userSetup
                                                              .weight!,
                                                          weightUnit: state
                                                              .userSetup
                                                              .weightUnit!,
                                                          height: state
                                                              .userSetup
                                                              .height!,
                                                          heightUnit: state
                                                              .userSetup
                                                              .heightUnit!,
                                                          age: state
                                                              .userSetup
                                                              .age!,
                                                          gender: state
                                                              .userSetup
                                                              .gender!,
                                                        ),

                                                        tdee: calculateTdee(
                                                          bmr: calculateBmr(
                                                            weight: state
                                                                .userSetup
                                                                .weight!,
                                                            weightUnit: state
                                                                .userSetup
                                                                .weightUnit!,
                                                            height: state
                                                                .userSetup
                                                                .height!,
                                                            heightUnit: state
                                                                .userSetup
                                                                .heightUnit!,
                                                            age: state
                                                                .userSetup
                                                                .age!,
                                                            gender: state
                                                                .userSetup
                                                                .gender!,
                                                          ),
                                                          activityLevel: state
                                                              .userSetup
                                                              .activityLevel!,
                                                        ),
                                                        targetCalories:
                                                            calculateTargetCalories(
                                                              goal: state
                                                                  .userSetup
                                                                  .fitnessGoal!,
                                                              tdee: calculateBmr(
                                                                weight: state
                                                                    .userSetup
                                                                    .weight!,
                                                                weightUnit: state
                                                                    .userSetup
                                                                    .weightUnit!,
                                                                height: state
                                                                    .userSetup
                                                                    .height!,
                                                                heightUnit: state
                                                                    .userSetup
                                                                    .heightUnit!,
                                                                age: state
                                                                    .userSetup
                                                                    .age!,
                                                                gender: state
                                                                    .userSetup
                                                                    .gender!,
                                                              ),
                                                            ),
                                                        weightDifference:
                                                            calculateWeightDifference(
                                                              currentWeight:
                                                                  state
                                                                      .userSetup
                                                                      .weight!,
                                                              targetWeight: state
                                                                  .userSetup
                                                                  .targetWeight!,
                                                              targetWeightUnit:
                                                                  state
                                                                      .userSetup
                                                                      .targetWeightUnit!,
                                                              weightUnit: state
                                                                  .userSetup
                                                                  .weightUnit!,
                                                            ),
                                                        weightChangePercentage:
                                                            calculateWeightChangePercentage(
                                                              currentWeight:
                                                                  state
                                                                      .userSetup
                                                                      .weight!,
                                                              targetWeight: state
                                                                  .userSetup
                                                                  .targetWeight!,
                                                              weightUnit: state
                                                                  .userSetup
                                                                  .weightUnit!,
                                                              targetWeightUnit:
                                                                  state
                                                                      .userSetup
                                                                      .targetWeightUnit!,
                                                            ),
                                                      );
                                                      AppToast.showSuccess(
                                                        context: context,
                                                        title: 'saved',
                                                        message:
                                                            state
                                                                .successMessage ??
                                                            'info saved successful',
                                                      );
                                                      pageController.nextPage(
                                                        duration:
                                                            const Duration(
                                                              milliseconds: 500,
                                                            ),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }
                                                  case 4:
                                                    await setupCubit
                                                        .updateSetupComplete(
                                                          isComplete: true,
                                                        );
                                                    Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeView(),
                                                      ),
                                                      (context) => false,
                                                    );
                                                    return;
                                                }
                                              },

                                              text: pageNumber == 4
                                                  ? 'Finish'
                                                  : 'Continue',
                                              fontSize: 16.sp,
                                              textColor: AppColors.primaryDark,
                                            );
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  pageNumber == 4
                                      ? CustomElvatedButton(
                                          onPressed: () {
                                            pageController.jumpTo(0);
                                          },
                                          text: 'Edit Profile',
                                          fontSize: 14.sp,
                                          borderRadius: 9999.r,
                                          border: Border.all(
                                            width: 1.w,
                                            color: AppColors.babyBlue2,
                                          ),
                                          colorContainer: AppColors.black,
                                          textColor: AppColors.babyBlue2,
                                        )
                                      : SizedBox(),
                                  SizedBox(height: 32.h),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
