import 'package:bloc/bloc.dart';
import 'package:kynex/core/helper/fitness_calculations.dart';
import 'package:kynex/features/setup_profile/data/enums/eunms.dart';
import 'package:meta/meta.dart';

part 'exercise_info_page_state.dart';

class ExerciseInfoPageCubit extends Cubit<ExerciseInfoPageState> {
  ExerciseInfoPageCubit() : super(const ExerciseInfoPageState());

  void selectLocation(ExerciseLocation location) {
    emit(state.copyWith(location: location));
  }

  void selectDuration(ExerciseDuration duration) {
    emit(state.copyWith(duration: duration));
  }

  void toggleDay(WeekDay day) {
    final updatedDays = <WeekDay>{...state.selectedDays};

    if (updatedDays.contains(day)) {
      updatedDays.remove(day);
    } else {
      updatedDays.add(day);
    }

    emit(state.copyWith(selectedDays: updatedDays));
  }

  void selectCurrentActivity(ActivityLevel currentActivityLevel) {
    emit(state.copyWith(currentActivityLevel: currentActivityLevel));
  }
}
