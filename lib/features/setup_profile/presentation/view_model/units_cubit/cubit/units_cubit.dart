import 'package:bloc/bloc.dart';
import 'package:kynex/core/helper/fitness_calculations.dart';
import 'package:meta/meta.dart';

part 'units_state.dart';

class UnitsCubit extends Cubit<UnitsState> {
  UnitsCubit() : super(UnitsInitial());
  bool isCm = true;
  bool isKg = true;
  void heightUnit() {
    isCm = !isCm;
    emit(HeightUnits());
  }

  void wightUnit() {
    isKg = !isKg;
    emit(WightUnits());
  }

  num convertHeight2(num height) {
    final converted = convertHeight(
      height: height,
      from: isCm ? HeightUnit.ft : HeightUnit.cm,
      to: isCm ? HeightUnit.cm : HeightUnit.ft,
    );
    return converted;
  }

  num convertWight2(num weight) {
    return convertWeight(
      weight: weight,
      from: isKg ? WeightUnit.lb : WeightUnit.kg,
      to: isKg ? WeightUnit.kg : WeightUnit.lb,
    );
  }
}
