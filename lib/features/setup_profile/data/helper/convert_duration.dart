import 'package:kynex/features/setup_profile/data/enums/eunms.dart';

int convertDuration(ExerciseDuration? duration) {
  int d = 0;
  if (duration == ExerciseDuration.quickHit) {
    return d = 15;
  } else if (duration == ExerciseDuration.standard) {
    return d = 30;
  } else if (duration == ExerciseDuration.intense) {
    return d = 45;
  } else if (duration == ExerciseDuration.endurance) {
    return d = 60;
  }
  return d;
}
