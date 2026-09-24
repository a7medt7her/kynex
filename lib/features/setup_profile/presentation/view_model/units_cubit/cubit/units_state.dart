part of 'units_cubit.dart';

@immutable
sealed class UnitsState {}

final class UnitsInitial extends UnitsState {}

final class HeightUnits extends UnitsState {}

final class WightUnits extends UnitsState {}

final class HeightConvert extends UnitsState {}

final class WightConvert extends UnitsState {}
