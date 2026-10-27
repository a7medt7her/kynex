part of 'exercise_info_page_cubit.dart';

@immutable
class ExerciseInfoPageState {
  final Set<WeekDay> selectedDays;

  const ExerciseInfoPageState({this.selectedDays = const {}});

  ExerciseInfoPageState copyWith({Set<WeekDay>? selectedDays}) {
    return ExerciseInfoPageState(
      selectedDays: selectedDays ?? this.selectedDays,
    );
  }
}
