import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/helper/app_validator.dart';
import 'package:kynex/core/helper/show_custom_snakbar.dart';
import 'package:kynex/core/helper/svg_helper.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/core/widgets/coustom_elvatedbutton.dart';
import 'package:kynex/core/widgets/custom_progress_indicator.dart';
import 'package:kynex/features/auth/presentation/view/forget_password_view.dart';
import 'package:kynex/features/auth/presentation/view/widgets/formname.dart';
import 'package:kynex/features/auth/presentation/view_model/login_cubit/cubit/login_cubit.dart';
import 'package:kynex/features/setup_profile/presentation/view/setup.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -250.h,
                right: -200.w,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                  child: Container(
                    width: 1000.w,
                    height: 800.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        radius: 1.0,
                        stops: const [0.0, 0.5],
                        colors: [
                          AppColors.primary2.withValues(alpha: 0.15),

                          AppColors.black,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 119.h, left: 24.w, right: 24.w),
                child: Column(
                  children: [
                    Container(
                      padding: REdgeInsets.all(16.15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.black2,
                      ),
                      child: svgHelper(
                        AssetsIcon.activeDomibble,
                        29.7.w,
                        29.7.h,
                      ),
                    ),

                    Text.rich(
                      TextSpan(
                        text: 'Kyn',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 32.sp,
                          fontWeight: AppTextStyle.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'EX',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 23.sp,
                              fontWeight: AppTextStyle.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      'Unleash your potential.',
                      style: TextStyle(
                        letterSpacing: 2.8.sp,
                        color: AppColors.secondary,
                        fontSize: 16.sp,
                        fontWeight: AppTextStyle.regular,
                        fontFamily: 'Inter',
                      ),
                    ),

                    SizedBox(height: 32.h),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.25),
                            offset: Offset(0, 25),
                            blurRadius: 50,
                            spreadRadius: -12,
                          ),
                        ],
                        color: AppColors.white.withValues(alpha: 0.03),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.white.withValues(alpha: 0.05),
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.w, sigmaY: 24.h),
                          child: Padding(
                            padding: REdgeInsets.all(24),
                            child: Form(
                              key: formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FormName(
                                    validator: AppValidator.emailValidator,
                                    name: 'Email',
                                    controller: email,
                                    hint: ' emma@kineticonyx.com',
                                    obscureText: false,
                                    prefixIcon: svgHelper(
                                      AssetsIcon.email,
                                      13.33.w,
                                      13.33.h,
                                    ),
                                  ),

                                  SizedBox(height: 16.h),
                                  BlocBuilder<LoginCubit, LoginState>(
                                    builder: (context, state) {
                                      return FormName(
                                        validator:
                                            AppValidator.passwordValidator,
                                        name: 'Password',
                                        controller: password,
                                        hint: '••••••••',
                                        obscureText: context
                                            .read<LoginCubit>()
                                            .visibility,
                                        prefixIcon: svgHelper(
                                          AssetsIcon.password,
                                          13.33.w,
                                          13.33.h,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            context
                                                .read<LoginCubit>()
                                                .isVisibility();
                                          },
                                          icon:
                                              context
                                                  .read<LoginCubit>()
                                                  .visibility
                                              ? svgHelper(
                                                  AssetsIcon.eyeOff,
                                                  13.33.w,
                                                  13.33.h,
                                                )
                                              : svgHelper(
                                                  AssetsIcon.eye,
                                                  13.33.w,
                                                  13.33.h,
                                                ),
                                        ),
                                      );
                                    },
                                  ),

                                  SizedBox(height: 16.h),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgetPasswordView(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color: AppColors.babyBlue,
                                        fontFamily: AppTextStyle.fontFamliy2,
                                        fontSize: 12.sp,
                                        fontWeight: AppTextStyle.medium,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  BlocConsumer<LoginCubit, LoginState>(
                                    listener: (context, state) {
                                      if (state is LoginError) {
                                        showSnackBar(
                                          context,
                                          text: state.massage,
                                          state: SnackBarState.fail,
                                        );
                                      }
                                      if (state is LoginSuccess) {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Setup(),
                                          ),
                                          (context) => false,
                                        );
                                      }
                                    },

                                    builder: (context, state) {
                                      if (state is LoginLoading) {
                                        return CustomProgressIndicator();
                                      }
                                      return CustomElvatedButton(
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            context.read<LoginCubit>().login(
                                              email.text,
                                              password.text,
                                            );
                                          }
                                        },
                                        textColor: AppColors.black3,
                                        text: 'Login',
                                        fontSize: 14.sp,
                                        borderRadius: 50.r,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Center(
                                      child: Text.rich(
                                        TextSpan(
                                          text: "Don't have an account? ",
                                          style: TextStyle(
                                            fontFamily:
                                                AppTextStyle.fontFamliy2,
                                            fontSize: 16.sp,
                                            fontWeight: AppTextStyle.regular,
                                            color: AppColors.secondary,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Sign Up',
                                              style: TextStyle(
                                                fontFamily:
                                                    AppTextStyle.fontFamliy2,
                                                fontSize: 16.sp,
                                                fontWeight:
                                                    AppTextStyle.regular,
                                                color: AppColors.babyBlue,
                                              ),
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
                        ),
                      ),
                    ),
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
