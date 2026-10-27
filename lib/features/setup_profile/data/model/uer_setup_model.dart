import 'package:kynex/features/setup_profile/data/helper/fitness_calculations.dart';
import 'package:kynex/features/setup_profile/data/enums/eunms.dart';

class UserSetupModel {
  final String? username;
  final GenderType? gender;
  final int? age;

  final num? height;
  final HeightUnit? heightUnit;

  final num? weight;
  final WeightUnit? weightUnit;

  final num? targetWeight;
  final WeightUnit? targetWeightUnit;

  final Levels? levels;
  final FitnessGoal? fitnessGoal;

  final ExerciseLocation? exerciseLocation;
  final ExerciseDuration? exerciseDuration;

  final ActivityLevel? activityLevel;

  final Set<WeekDay> weekDay;
  final num? bmi;
  final num? bmr;

  final num? tdee;
  final num? targetCalories;
  final num? weightDifference;
  final num? weightChangePercentage;
  final num? targetBmi;
  UserSetupModel({
    this.gender,
    this.age = 0,
    this.height,
    this.heightUnit = HeightUnit.cm,
    this.weight,
    this.weightUnit = WeightUnit.kg,
    this.targetWeight,
    this.targetWeightUnit = WeightUnit.kg,
    this.levels,
    this.fitnessGoal,
    this.exerciseLocation,
    this.exerciseDuration,
    this.activityLevel,
    this.weekDay = const {},
    this.bmi,
    this.bmr,
    this.tdee,
    this.targetCalories,
    this.weightDifference,
    this.weightChangePercentage,
    this.targetBmi,
    this.username,
  });

  UserSetupModel copyWith({
    GenderType? gender,
    int? age,
    num? height,
    HeightUnit? heightUnit,
    num? weight,
    WeightUnit? weightUnit,
    num? targetWeight,
    WeightUnit? targetWeightUnit,
    Levels? levels,
    FitnessGoal? fitnessGoal,
    ExerciseLocation? exerciseLocation,
    ExerciseDuration? exerciseDuration,
    ActivityLevel? activityLevel,
    Set<WeekDay>? weekDay,
  }) {
    return UserSetupModel(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      heightUnit: heightUnit ?? this.heightUnit,
      weight: weight ?? this.weight,
      weightUnit: weightUnit ?? this.weightUnit,
      targetWeight: targetWeight ?? this.targetWeight,
      targetWeightUnit: targetWeightUnit ?? this.targetWeightUnit,
      levels: levels ?? this.levels,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      exerciseLocation: exerciseLocation ?? this.exerciseLocation,
      exerciseDuration: exerciseDuration ?? this.exerciseDuration,
      activityLevel: activityLevel ?? this.activityLevel,
      weekDay: weekDay ?? this.weekDay,
    );
  }

  factory UserSetupModel.fromJson(Map<String, dynamic> map) {
    return UserSetupModel(
      username: map['userName'] as String?,
      gender: map['gander'] == null
          ? null
          : GenderType.values.byName(map['gander']),
      activityLevel: map['activityLevel'] == null
          ? null
          : ActivityLevel.values.byName(map['activityLevel']),
      fitnessGoal: map['goal'] == null
          ? null
          : FitnessGoal.values.byName(map['goal']),
      age: map['age'] as int?,
      height: map['height'] as num?,
      heightUnit: map['heightUnite'] == null
          ? null
          : HeightUnit.values.byName(map['heightUnite']),

      weight: map['weight'] as num?,
      weightUnit: map['weightUnite'] == null
          ? null
          : WeightUnit.values.byName(map['weightUnite']),
      targetWeight: map['targetWeight'] as num?,
      targetWeightUnit: map['tWightUnite'] == null
          ? null
          : WeightUnit.values.byName(map['tWightUnite']),
      exerciseDuration: map['duration'] == null
          ? null
          : ExerciseDuration.values.byName(map['duration']),
      levels: map['currentLevel'] == null
          ? null
          : Levels.values.byName(map['currentLevel']),
      exerciseLocation: map['location'] == null
          ? null
          : ExerciseLocation.values.byName(map['location']),

      weekDay: ((map['days'] as List<dynamic>?) ?? [])
          .map((d) => WeekDay.values.byName(d))
          .toSet(),
      bmi: map['bmi'] as num?,
      bmr: map['bmr'] as num?,
      tdee: map['tdee'] as num?,
      targetCalories: map['targetCalories'] as num?,
      weightDifference: map['weightDifference'] as num?,
      weightChangePercentage: map['weightChangePercentage'] as num?,
      targetBmi: map['targetBmi'] as num?,
    );
  }
}
