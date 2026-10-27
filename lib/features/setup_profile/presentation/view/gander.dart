import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/features/setup_profile/data/helper/fitness_calculations.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/gander_card_slected.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/gander_card_unslected.dart';
import 'package:kynex/features/setup_profile/presentation/view_model/setup_cubit/cubit/setup_cubit.dart';

class Gander extends StatelessWidget {
  const Gander({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
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

          BlocSelector<SetupCubit, SetupState, GenderType?>(
            selector: (state) {
              return state.userSetup.gender;
            },
            builder: (context, state) {
              final setupCubit = context.read<SetupCubit>();
              return Column(
                children: [
                  state == GenderType.male
                      ? GanderCardSelected(
                          ganderTyp: 'Male',
                          image: AssetsIcon.man,
                        )
                      : GestureDetector(
                          onTap: () {
                            setupCubit.saveGender(GenderType.male);
                          },
                          child: GanderCardUnselected(
                            ganderTyp: 'Male',
                            image: AssetsIcon.man,
                          ),
                        ),

                  SizedBox(height: 16.h),

                  state == GenderType.female
                      ? GanderCardSelected(
                          ganderTyp: 'Female',
                          image: AssetsIcon.woman,
                        )
                      : GestureDetector(
                          onTap: () {
                            setupCubit.saveGender(GenderType.female);
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
    );
  }
}
