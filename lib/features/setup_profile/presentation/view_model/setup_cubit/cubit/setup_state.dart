part of 'setup_cubit.dart';

enum SetupStatus { initial, loading, success, failure, dataLoading }

@immutable
class SetupState {
  final UserSetupModel userSetup;
  final SetupStatus status;
  final String? errorMessage;
  final String? successMessage;
  const SetupState({
    required this.userSetup,
    this.status = SetupStatus.initial,
    this.errorMessage,
    this.successMessage,
  });

  SetupState copyWith({
    UserSetupModel? userSetup,
    SetupStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return SetupState(
      userSetup: userSetup ?? this.userSetup,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
