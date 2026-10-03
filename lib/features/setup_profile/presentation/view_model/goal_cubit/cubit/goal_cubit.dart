import 'package:bloc/bloc.dart';
import 'package:kynex/core/helper/fitness_calculations.dart';
import 'package:kynex/features/setup_profile/data/enums/eunms.dart';
import 'package:meta/meta.dart';

part 'goal_state.dart';

class GoalCubit extends Cubit<GoalState> {
  GoalCubit() : super(GoalInitial());

  Levels? selectedLevel;
  FitnessGoal? selectedGoal;

  void selectLevel(Levels level) {
    selectedLevel = level;
    emit(LevelSelected());
  }

  void selectGoal(FitnessGoal goal) {
    selectedGoal = goal;
    emit(GoalSelected());
  }
}
