import 'package:flutter/material.dart';
import 'package:kynex/core/helper/fitness_calculations.dart';

void switchUnits({
  required void Function(HeightUnit) heightUnit,
  required num Function(num value) convertHeight2,
  required bool unit,
  required HeightUnit selectedUnit,
  required TextEditingController controllerText,
}) {
  heightUnit(selectedUnit);
  final value = num.tryParse(controllerText.text);

  if (value == null) return;

  final convertedHeight = !unit ? convertHeight2(value) : null;
  if (convertedHeight != null) {
    controllerText.text = convertedHeight.toString();
  }
}

void switchWeight({
  required void Function(WeightUnit) weightUnit,
  required num Function(num value) convertWeight2,
  required bool unit,
  required WeightUnit selectedUnit,
  required TextEditingController controllerText,
}) {
  weightUnit(selectedUnit);
  final value = num.tryParse(controllerText.text);

  if (value == null) return;

  final convertedWeight = !unit ? convertWeight2(value) : null;
  if (convertedWeight != null) {
    controllerText.text = convertedWeight.toString();
  }
}
