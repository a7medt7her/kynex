part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SuccessGetData extends SplashState {
  final int? whichPage;
  final bool? isSetupComplete;
  final String? successMassage;
  SuccessGetData({
    required this.isSetupComplete,
    required this.whichPage,
    required this.successMassage,
  });
}

final class FiledGetData extends SplashState {
  final String? filedMassage;
  FiledGetData({required this.filedMassage});
}
