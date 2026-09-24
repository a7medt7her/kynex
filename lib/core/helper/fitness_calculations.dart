import 'dart:math';

enum Gender { male, female }

enum FitnessGoal { muscleGain, weightLoss, flexibility, endurance }

enum ActivityLevel {
  sedentary,
  lightlyActive,
  moderatelyActive,
  veryActive,
  extremelyActive,
}

enum WeightUnit { kg, lb }

enum HeightUnit { cm, ft }

num convertWeight({
  required num weight,
  required WeightUnit from,
  required WeightUnit to,
}) {
  if (from == to) return weight;

  if (from == WeightUnit.kg && to == WeightUnit.lb) {
    return weight / 0.45359237;
  }

  if (from == WeightUnit.lb && to == WeightUnit.kg) {
    return weight * 0.45359237;
  }

  return weight;
}

num convertHeight({
  required num height,
  required HeightUnit from,
  required HeightUnit to,
}) {
  if (from == to) return height;

  if (from == HeightUnit.cm && to == HeightUnit.ft) {
    return height / 30.48;
  }

  if (from == HeightUnit.ft && to == HeightUnit.cm) {
    return height * 30.48;
  }

  return height;
}

num calculateBmi({
  required num weight,
  required WeightUnit weightUnit,
  required num height,
  required HeightUnit heightUnit,
}) {
  final weightKg = convertWeight(
    weight: weight,
    from: weightUnit,
    to: weightUnit,
  );

  final heightCm = convertHeight(
    height: height,
    to: heightUnit,
    from: heightUnit,
  );

  final heightM = heightCm / 100;

  return weightKg / pow(heightM, 2);
}

num calculateBmr({
  required num weight,
  required WeightUnit weightUnit,
  required num height,
  required HeightUnit heightUnit,
  required int age,
  required Gender gender,
}) {
  final weightKg = convertWeight(
    weight: weight,
    from: weightUnit,
    to: weightUnit,
  );

  final heightCm = convertHeight(
    height: height,
    to: heightUnit,
    from: heightUnit,
  );

  if (gender == Gender.male) {
    return (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
  }

  return (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;
}

double getActivityFactor(ActivityLevel activityLevel) {
  switch (activityLevel) {
    case ActivityLevel.sedentary:
      return 1.2;

    case ActivityLevel.lightlyActive:
      return 1.375;

    case ActivityLevel.moderatelyActive:
      return 1.55;

    case ActivityLevel.veryActive:
      return 1.725;

    case ActivityLevel.extremelyActive:
      return 1.9;
  }
}

num calculateTdee({required num bmr, required ActivityLevel activityLevel}) {
  final activityFactor = getActivityFactor(activityLevel);

  return bmr * activityFactor;
}

num calculateTargetCalories({required num tdee, required FitnessGoal goal}) {
  switch (goal) {
    case FitnessGoal.weightLoss:
      return tdee * 0.85;

    case FitnessGoal.muscleGain:
      return tdee * 1.10;

    case FitnessGoal.flexibility:
    case FitnessGoal.endurance:
      return tdee;
  }
}

num calculateWeightDifference({
  required num currentWeight,
  required num targetWeight,
  required WeightUnit weightUnit,
}) {
  final currentWeightKg = convertWeight(
    weight: currentWeight,
    from: weightUnit,
    to: weightUnit,
  );

  final targetWeightKg = convertWeight(
    weight: targetWeight,
    from: weightUnit,
    to: weightUnit,
  );

  return (currentWeightKg - targetWeightKg).abs();
}

num calculateWeightChangePercentage({
  required num currentWeight,
  required num targetWeight,
  required WeightUnit weightUnit,
}) {
  final currentWeightKg = convertWeight(
    weight: currentWeight,
    from: weightUnit,
    to: weightUnit,
  );

  final targetWeightKg = convertWeight(
    weight: targetWeight,
    from: weightUnit,
    to: weightUnit,
  );

  return ((currentWeightKg - targetWeightKg).abs() / currentWeightKg) * 100;
}

num calculateTargetBmi({
  required num targetWeight,
  required WeightUnit weightUnit,
  required num height,
  required HeightUnit heightUnit,
}) {
  final targetWeightKg = convertWeight(
    weight: targetWeight,
    from: weightUnit,
    to: weightUnit,
  );

  final heightCm = convertHeight(
    height: height,
    to: heightUnit,
    from: heightUnit,
  );

  final heightM = heightCm / 100;

  return targetWeightKg / pow(heightM, 2);
}
