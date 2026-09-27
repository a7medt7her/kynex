import 'package:bloc/bloc.dart';
import 'package:kynex/core/helper/fitness_calculations.dart';
import 'package:meta/meta.dart';

part 'units_state.dart';

class UnitsCubit extends Cubit<UnitsState> {
  UnitsCubit() : super(UnitsInitial());
  WeightUnit? weightUnit = WeightUnit.kg;
  HeightUnit? heightUnit = HeightUnit.cm;

  void heightUnits(HeightUnit h) {
    heightUnit = h;
    emit(HeightUnits());
  }

  void wightUnit(WeightUnit w) {
    weightUnit = w;
    emit(WightUnits());
  }

  num convertedHeight(num height) {
    final converted = convertHeight(
      height: height,
      from: heightUnit == HeightUnit.cm ? HeightUnit.cm : HeightUnit.ft,
      to: heightUnit == HeightUnit.cm ? HeightUnit.ft : HeightUnit.cm,
    );
    return converted;
  }

  num convertedWight(num weight) {
    return convertWeight(
      weight: weight,
      from: weightUnit == WeightUnit.kg ? WeightUnit.kg : WeightUnit.lb,
      to: weightUnit == WeightUnit.kg ? WeightUnit.lb : WeightUnit.kg,
    );
  }
}
