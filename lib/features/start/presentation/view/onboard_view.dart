import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/helper/svg_helper.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/core/widgets/coustom_elvatedbutton.dart';
import 'package:kynex/features/auth/presentation/view/login_view.dart';
import 'package:kynex/features/start/helper/next_page.dart';
import 'package:kynex/features/start/presentation/view/widgets/onboard_body.dart';
import 'package:kynex/features/start/presentation/view/widgets/onboard_indicator.dart';
import 'package:kynex/features/start/presentation/view_model/cubit/onboard_cubit.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  final PageController _pageController = PageController();

  final List<Widget> pages = [
    OnboardBody(
      text1: 'Track Your Progress',
      text2:
          'Monitor your daily performance metrics with precision. Visualize your journey through high-fidelity data and watch your dedication transform into tangible results.',
      image: Images.page1,
    ),
    OnboardBody(
      text1: 'Set Your Targets',
      text2:
          'Define what drives you. Build a personalized plan to crush your milestones with precision.',
      image: Images.page2,
    ),
    OnboardBody(
      text1: 'Join the Community',
      text2:
          'Connect with thousands of athletes, share your progress, and crush your goals together.',
      image: Images.page3,
    ),
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardCubit(),
      child: Scaffold(
        backgroundColor: AppColors.black3,
        body: BlocBuilder<OnboardCubit, int>(
          builder: (context, state) {
            final bool isLast = state == pages.length - 1;
            return Column(
              children: [
                SizedBox(
                  height: isLast ? 700.h : 750.h,

                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      context.read<OnboardCubit>().navigatorPage(value);
                    },
                    itemCount: pages.length,
                    itemBuilder: (context, index) => pages[index],
                  ),
                ),
                SizedBox(height: 10.h),
                OnboardIndicator(currentIndex: state, length: pages.length),
                SizedBox(height: 20.h),
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 20),

                  child: CustomElvatedButton(
                    sizedBoxWidth: 10.w,
                    widget: svgHelper(AssetsIcon.rightArrow, 13.33.w, 13.33.h),
                    onPressed: () =>
                        nextPage(context, _pageController, state, pages.length),
                    text: isLast ? 'GET STARTED' : 'Next',
                    fontSize: 14,
                    textColor: Color(0xFF556D00),
                  ),
                ),
                isLast
                    ? TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginView(),
                            ),
                            (context) => false,
                          );
                        },
                        child: Text(
                          'Log in to existing account',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.sp,
                            fontWeight: AppTextStyle.medium,
                            color: AppColors.secondary,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}
