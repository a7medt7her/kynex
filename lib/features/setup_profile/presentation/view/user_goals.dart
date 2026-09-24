import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kynex/core/unitles/app_color.dart';
import 'package:kynex/core/unitles/app_text_style.dart';
import 'package:kynex/core/unitles/asstes.dart';
import 'package:kynex/features/setup_profile/data/model/cards_models.dart';
import 'package:kynex/features/setup_profile/presentation/view/widgets/cards.dart';

class UserGoals extends StatelessWidget {
  const UserGoals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Text(
                'Your Fitness Profile',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24.sp,
                  fontWeight: AppTextStyle.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Help us customize your experience by selecting your current level and primary goal.',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamliy2,
                  color: AppColors.secondary,
                  fontSize: 16.sp,
                  fontWeight: AppTextStyle.regular,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Level',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20.sp,
                      fontWeight: AppTextStyle.semiBold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Cards(
                    text1: 'Beginner',

                    icon: AssetsIcon.beginner,
                    child: Text(
                      'Just starting out',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamliy2,
                        fontSize: 12.sp,
                        fontWeight: AppTextStyle.medium,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Cards(
                    text1: 'Intermediate',

                    icon: AssetsIcon.dumbbil,
                    child: Text(
                      'Familiar with training',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamliy2,
                        fontSize: 12.sp,
                        fontWeight: AppTextStyle.medium,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Cards(
                    text1: 'Advanced',

                    icon: AssetsIcon.advanced,
                    child: Text(
                      'Experienced athlete',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamliy2,
                        fontSize: 12.sp,
                        fontWeight: AppTextStyle.medium,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Primary Goal',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20.sp,
                      fontWeight: AppTextStyle.semiBold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 700.h,
                    width: double.infinity,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                      itemCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final List<CardsModels> listData = [
                          CardsModels(
                            text: 'Lose Weight',
                            icon: AssetsIcon.loseWeight,
                          ),
                          CardsModels(
                            text: 'Build Muscle',
                            icon: AssetsIcon.dumbbil,
                          ),
                          CardsModels(
                            text: 'Endurance',
                            icon: AssetsIcon.endurance,
                          ),
                          CardsModels(
                            text: 'Flexibility',
                            icon: AssetsIcon.flexibility,
                          ),
                        ];
                        final data = listData[index];
                        return Cards(
                          height: 0,
                          text1: data.text,
                          icon: data.icon,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
