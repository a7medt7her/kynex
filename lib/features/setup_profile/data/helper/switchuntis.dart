import 'package:flutter/material.dart';

void switchUnits({
  required void Function() heightUnit,
  required num Function(num value) convertHeight2,
  required bool unit,
  required TextEditingController controllerText,
}) {
  !unit ? heightUnit() : null;
  final value = num.tryParse(controllerText.text);

  if (value == null) return;

  final convertedHeight = !unit ? convertHeight2(value) : null;
  if (convertedHeight != null) {
    controllerText.text = convertedHeight.toString();
  }
}

void switchUnits2({
  required void Function() heightUnit,
  required num Function(num value) convertHeight2,
  required bool unit,
  required TextEditingController controllerText,
}) {
  unit ? heightUnit() : null;
  final value = num.tryParse(controllerText.text);

  if (value == null) return;

  final convertedHeight = unit ? convertHeight2(value) : null;
  if (convertedHeight != null) {
    controllerText.text = convertedHeight.toString();
  }
}
