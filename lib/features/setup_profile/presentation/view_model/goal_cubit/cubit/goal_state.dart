part of 'goal_cubit.dart';

@immutable
sealed class GoalState {}

final class GoalInitial extends GoalState {}

final class LevelSelected extends GoalState {}

final class GoalSelected extends GoalState {}
