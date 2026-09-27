import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/helper/fitness_calculations.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/gander_card_slected.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/gander_card_unslected.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/gander_cubit/cubit/gander_cubit.dart';

class Gander extends StatelessWidget {
  const Gander({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GanderCubit(),
      child: Scaffold(
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 21.w),
          child: Column(
            children: [
              SizedBox(height: 104.h),
              Text(
                'Tell us about yourself',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24.sp,
                  fontWeight: AppTextStyle.bold,
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: 271.27.w,

                child: Text(
                  'To give you a customize experience we need to know your gender',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamliy2,
                    color: AppColors.secondary,
                    fontSize: 16.sp,
                    fontWeight: AppTextStyle.regular,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 89.h),
              BlocBuilder<GanderCubit, GanderState>(
                builder: (context, state) {
                  final cubit = context.read<GanderCubit>();

                  return Column(
                    children: [
                      cubit.ganderSelected == GenderType.male
                          ? GanderCardSelected(
                              ganderTyp: 'Male',
                              image: AssetsIcon.man,
                            )
                          : GestureDetector(
                              onTap: () {
                                cubit.ganderSelect(GenderType.male);
                              },
                              child: GanderCardUnselected(
                                ganderTyp: 'Male',
                                image: AssetsIcon.man,
                              ),
                            ),
                      SizedBox(height: 16.h),
                      cubit.ganderSelected == GenderType.female
                          ? GanderCardSelected(
                              ganderTyp: 'Female',
                              image: AssetsIcon.woman,
                            )
                          : GestureDetector(
                              onTap: () {
                                cubit.ganderSelect(GenderType.female);
                              },
                              child: GanderCardUnselected(
                                ganderTyp: 'Female',
                                image: AssetsIcon.woman,
                              ),
                            ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
