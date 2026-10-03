part of 'exercise_info_page_cubit.dart';

@immutable
class ExerciseInfoPageState {
  final ExerciseLocation? location;
  final ExerciseDuration? duration;
  final Set<WeekDay> selectedDays;
  final ActivityLevel? currentActivityLevel;
  const ExerciseInfoPageState({
    this.location,
    this.duration,
    this.selectedDays = const {},
    this.currentActivityLevel,
  });

  ExerciseInfoPageState copyWith({
    ExerciseLocation? location,
    ExerciseDuration? duration,
    Set<WeekDay>? selectedDays,
    ActivityLevel? currentActivityLevel,
  }) {
    return ExerciseInfoPageState(
      location: location ?? this.location,
      duration: duration ?? this.duration,
      selectedDays: selectedDays ?? this.selectedDays,
      currentActivityLevel: currentActivityLevel ?? this.currentActivityLevel,
    );
  }
}
