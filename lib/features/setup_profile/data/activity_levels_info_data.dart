import 'package:kynex/core/helper/fitness_calculations.dart';
import 'package:kynex/features/setup_profile/data/model/activity_level.dart';

const activityLevels = [
  ActivityLevels(
    a: ActivityLevel.sedentary,
    title: 'Sedentary',
    subTitle: 'Little or no exercise',
  ),

  ActivityLevels(
    a: ActivityLevel.lightlyActive,
    title: 'Lightly Active',
    subTitle: 'Light exercise 1–3 days a week',
  ),

  ActivityLevels(
    a: ActivityLevel.moderatelyActive,
    title: 'Moderately Active',
    subTitle: 'Moderate exercise 3–5 days a week',
  ),

  ActivityLevels(
    a: ActivityLevel.veryActive,
    title: 'Very Active',
    subTitle: 'Hard exercise 6–7 days a week',
  ),

  ActivityLevels(
    a: ActivityLevel.extremelyActive,
    title: 'Extremely Active',
    subTitle: 'Hard training or physical work every day',
  ),
];
