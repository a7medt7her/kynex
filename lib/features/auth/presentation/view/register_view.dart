import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/helper/app_validator.dart';
import 'package:kynex/core/helper/svg_helper.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/core/widgets/coustom_elvatedbutton.dart';
import 'package:kynex/core/widgets/custom_progress_indicator.dart';
import 'package:kynex/features/auth/presentation/view/login_view.dart';
import 'package:kynex/features/auth/presentation/view/widgets/formname.dart';
import 'package:kynex/features/auth/presentation/view_model/register_cubit/cubit/register_cubit.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController username = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: -250.h,
                left: -100.w,
                child: Container(
                  width: 600.w,
                  height: 600.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: const Alignment(0, -1),
                      radius: 1.0,
                      stops: const [0.0, 0.6, 1.0],
                      colors: [
                        AppColors.primary2.withValues(alpha: 0.15),
                        AppColors.primary2.withValues(alpha: 0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 119.h, left: 24.w, right: 24.w),
                child: Column(
                  children: [
                    Text(
                      'kynex',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24.sp,
                        fontWeight: AppTextStyle.bold,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      'Join the elite. Start your journey.',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 16.sp,
                        fontWeight: AppTextStyle.regular,
                        fontFamily: AppTextStyle.fontFamliy2,
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
                      child: Stack(
                        children: [
                          Positioned(
                            top: -250.h,
                            left: 70.w,
                            child: Container(
                              width: 500.w,
                              height: 500.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  radius: 1.0,
                                  stops: const [0.0, 0.6],
                                  colors: [
                                    AppColors.primary2.withValues(alpha: 0.15),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: REdgeInsets.all(24),
                            child: Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  FormName(
                                    validator: AppValidator.checkFelid,
                                    name: 'Full Name',
                                    controller: username,
                                    hint: 'Emma Fitness',
                                    obscureText: false,
                                    prefixIcon: svgHelper(
                                      AssetsIcon.user,
                                      13.33.w,
                                      13.33.h,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
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
                                  BlocBuilder<RegisterCubit, RegisterState>(
                                    builder: (context, state) {
                                      return FormName(
                                        validator:
                                            AppValidator.passwordValidator,
                                        name: 'Password',
                                        controller: password,
                                        hint: '••••••••',
                                        obscureText: context
                                            .read<RegisterCubit>()
                                            .visibility,
                                        prefixIcon: svgHelper(
                                          AssetsIcon.password,
                                          13.33.w,
                                          13.33.h,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            context
                                                .read<RegisterCubit>()
                                                .isVisibility();
                                          },
                                          icon:
                                              context
                                                  .read<RegisterCubit>()
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
                                  BlocBuilder<RegisterCubit, RegisterState>(
                                    builder: (context, state) {
                                      return FormName(
                                        validator: (p0) =>
                                            AppValidator.passwordConfirmValidator(
                                              p0,
                                              password.text,
                                            ),

                                        name: 'Confirm Password',
                                        controller: confirmPassword,
                                        hint: '••••••••',
                                        obscureText: context
                                            .read<RegisterCubit>()
                                            .visibility2,
                                        prefixIcon: svgHelper(
                                          AssetsIcon.password,
                                          13.33.w,
                                          13.33.h,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            context
                                                .read<RegisterCubit>()
                                                .isVisibility2();
                                          },
                                          icon:
                                              context
                                                  .read<RegisterCubit>()
                                                  .visibility2
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
                                  SizedBox(height: 32.h),
                                  BlocBuilder<RegisterCubit, RegisterState>(
                                    builder: (context, state) {
                                      if (state is RegisterLoading) {
                                        return CustomProgressIndicator();
                                      }
                                      if (state is SaveUserLoading) {
                                        return CustomProgressIndicator();
                                      }
                                      return CustomElvatedButton(
                                        textColor: AppColors.primaryDark,
                                        sizedBoxWidth: 10.w,
                                        widget: svgHelper(
                                          AssetsIcon.rightArrow,
                                          13.33.w,
                                          13.33.h,
                                        ),
                                        onPressed: () async {
                                          if (formkey.currentState!
                                              .validate()) {
                                            await context
                                                .read<RegisterCubit>()
                                                .register(
                                                  email.text,
                                                  password.text,
                                                );
                                            await context
                                                .read<RegisterCubit>()
                                                .saveUser(
                                                  email.text,
                                                  username.text,
                                                  false,
                                                  DateTime.now(),
                                                );
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginView(),
                                              ),
                                              (context) => false,
                                            );
                                          }
                                        },
                                        text: 'Register',

                                        fontSize: 14.sp,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginView(),
                                        ),
                                      );
                                    },
                                    child: Text.rich(
                                      textAlign: TextAlign.center,
                                      TextSpan(
                                        text: 'Already have an account? ',
                                        style: TextStyle(
                                          fontFamily: AppTextStyle.fontFamliy2,
                                          fontSize: 16.sp,
                                          fontWeight: AppTextStyle.regular,
                                          color: AppColors.secondary,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Login',
                                            style: TextStyle(
                                              fontFamily:
                                                  AppTextStyle.fontFamliy2,
                                              fontSize: 16.sp,
                                              fontWeight: AppTextStyle.regular,
                                              color: AppColors.babyBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
