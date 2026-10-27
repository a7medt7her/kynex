import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/helper/svg_helper.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/unitles/app_toast.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/features/home/home_view.dart';
import 'package:kynex/features/setup_profile/presentation/view/setup.dart';
import 'package:kynex/features/start/data/data_source/splash_data_source.dart';
import 'package:kynex/features/start/data/repo/splash_repository.dart';
import 'package:kynex/features/start/presentation/view/onboard_view.dart';
import 'package:kynex/features/start/presentation/view/widgets/loading_indicato.dart';
import 'package:kynex/features/start/presentation/view_model/splash_cubit/cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  int activeIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          activeIndex = (activeIndex + 1) % 3;
        });

        _controller.forward(from: 0);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        splashRepository: SplashRepository(
          splashDataSource: SplashDataSource(),
        ),
      )..getData(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            if (state is SuccessGetData) {
              if (!state.isSetupComplete!) {
                AppToast.showSuccess(
                  context: context,
                  message: state.successMassage!,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Setup(pageComplete: state.whichPage ?? 1),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              }
            } else if (state is FiledGetData) {
              AppToast.showFailure(
                context: context,
                message: 'something wrong',
              );
            }
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OnboardView()),
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(76, 0, 0, 0),
                        Color.fromARGB(123, 24, 48, 15),
                        Colors.black,
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 350.h,
                left: 200.w,
                child: Container(
                  width: 500.w,
                  height: 500.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(16, 104, 103, 103),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Positioned(
                top: 350.h,
                left: 250.w,
                child: Container(
                  width: 500.w,
                  height: 500.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(16, 104, 103, 103),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Positioned(
                top: 200.h,
                left: 110.w,
                child: Column(
                  children: [
                    Container(
                      padding: REdgeInsets.all(30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.black2,
                      ),
                      child: svgHelper(AssetsIcon.activeDomibble, 66.w, 66.h),
                    ),

                    SizedBox(height: 48.h),

                    Text.rich(
                      TextSpan(
                        text: 'Kyn',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 34.sp,
                          fontWeight: AppTextStyle.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'ex',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 34.sp,
                              fontWeight: AppTextStyle.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      'ELITE PERFORMANCE',
                      style: TextStyle(
                        letterSpacing: 2.8.sp,
                        color: AppColors.secondary,
                        fontSize: 14.sp,
                        fontWeight: AppTextStyle.semiBold,
                        fontFamily: 'Inter',
                      ),
                    ),

                    SizedBox(height: 250.h),

                    LoadingIndicato(activeIndex: activeIndex),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
