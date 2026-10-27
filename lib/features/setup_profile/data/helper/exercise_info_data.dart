import 'package:kynex/features/setup_profile/data/enums/eunms.dart';
import 'package:kynex/features/setup_profile/data/model/duration_model.dart';

const dataDuration = [
  DurationModel(
    title: '15 min',
    subTitle: 'Quick hit',
    d: ExerciseDuration.quickHit,
  ),
  DurationModel(
    title: '30 min',
    subTitle: 'Standard',
    d: ExerciseDuration.standard,
  ),
  DurationModel(
    title: '45 min',
    subTitle: 'Intense',
    d: ExerciseDuration.intense,
  ),
  DurationModel(
    title: '60+ min',
    subTitle: 'Endurance',
    d: ExerciseDuration.endurance,
  ),
];
