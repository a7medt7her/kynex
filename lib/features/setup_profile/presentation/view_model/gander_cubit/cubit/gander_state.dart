part of 'gander_cubit.dart';

@immutable
sealed class GanderState {}

final class GanderInitial extends GanderState {}

final class SaveDataLoading extends GanderState {}

final class SaveDataSuccess extends GanderState {}

final class SaveDataError extends GanderState {
  final String massage;
  SaveDataError({required this.massage});
}

final class Man extends GanderState {}

final class Woman extends GanderState {}
