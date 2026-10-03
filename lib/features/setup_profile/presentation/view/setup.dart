import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/widgets/coustom_elvatedbutton.dart';
import 'package:kynex/features/setup_profile/presentation/view/exercise_info.dart';
import 'package:kynex/features/setup_profile/presentation/view/gander.dart';
import 'package:kynex/features/setup_profile/presentation/view/user_body.dart';
import 'package:kynex/features/setup_profile/presentation/view/user_goals.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/setup_indicator.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/setup_indicator/cubit/setup_indicator_cubit.dart';

class Setup extends StatelessWidget {
  Setup({super.key});
  final pageController = PageController();
  final List<Widget> pages = const [
    Gander(),
    UserBody(),
    UserGoals(),
    ExerciseInfo(),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => SetupIndicatorCubit())],
      child: Scaffold(
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<SetupIndicatorCubit, int>(
            builder: (context, state) {
              var cubit = context.read<SetupIndicatorCubit>();
              return Column(
                children: [
                  SizedBox(height: 50.h),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ),
                        icon: const Icon(
                          color: AppColors.white,
                          Icons.arrow_back_ios_new,
                        ),
                      ),
                      SizedBox(width: 40.w),
                      SetupIndicator(currentPage: state),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (value) => cubit.currentPage(value),
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: pages.length,
                      itemBuilder: (context, index) {
                        return pages[index];
                      },
                    ),
                  ),
                  SizedBox(height: 32.h),
                  CustomElvatedButton(
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Continue',
                    fontSize: 20.sp,
                    textColor: AppColors.primaryDark,
                  ),
                  SizedBox(height: 32.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
