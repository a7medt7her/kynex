import 'package:bloc/bloc.dart';
import 'package:kynex/features/setup_profile/data/enums/eunms.dart';
import 'package:meta/meta.dart';

part 'exercise_info_page_state.dart';

class ExerciseInfoPageCubit extends Cubit<ExerciseInfoPageState> {
  ExerciseInfoPageCubit() : super(const ExerciseInfoPageState());

  Set<WeekDay> toggleDay(WeekDay day) {
    final updatedDays = <WeekDay>{...state.selectedDays};

    if (updatedDays.contains(day)) {
      updatedDays.remove(day);
    } else {
      updatedDays.add(day);
    }

    emit(state.copyWith(selectedDays: updatedDays));

    return updatedDays;
  }
}
