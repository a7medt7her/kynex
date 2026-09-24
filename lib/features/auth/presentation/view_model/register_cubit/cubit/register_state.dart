part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final String message;
  RegisterSuccess({required this.message});
}

final class RegisterError extends RegisterState {
  final String message;
  RegisterError({required this.message});
}

final class Visibility extends RegisterState {}

final class SaveUserError extends RegisterState {
  final String message;
  SaveUserError({required this.message});
}

final class SaveUserSuccess extends RegisterState {}

final class SaveUserLoading extends RegisterState {}
