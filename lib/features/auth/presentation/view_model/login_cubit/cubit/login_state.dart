part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String massage;
  LoginSuccess({required this.massage});
}

final class LoginError extends LoginState {
  final String massage;
  LoginError({required this.massage});
}

final class Visibility extends LoginState {}
