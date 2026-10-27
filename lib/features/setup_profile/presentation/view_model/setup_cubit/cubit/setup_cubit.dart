import 'package:bloc/bloc.dart';
import 'package:kynex/features/setup_profile/data/helper/fitness_calculations.dart';
import 'package:kynex/core/services/app_dependencies.dart';
import 'package:kynex/features/setup_profile/data/data_sources/user_data_sources.dart';
import 'package:kynex/features/setup_profile/data/enums/eunms.dart';
import 'package:kynex/features/setup_profile/data/model/uer_setup_model.dart';
import 'package:kynex/features/setup_profile/data/repo/user_setup_repository.dart';
import 'package:meta/meta.dart';

part 'setup_state.dart';

class SetupCubit extends Cubit<SetupState> {
  SetupCubit({required this.userSetupRepository})
    : super(SetupState(userSetup: UserSetupModel()));
  final UserSetupRepository userSetupRepository;
  void saveGender(GenderType gender) {
    emit(state.copyWith(userSetup: state.userSetup.copyWith(gender: gender)));
  }

  void saveAge({required int age}) {
    emit(state.copyWith(userSetup: state.userSetup.copyWith(age: age)));
  }

  void saveHeight({required num height, required HeightUnit heightUnit}) {
    emit(
      state.copyWith(
        userSetup: state.userSetup.copyWith(
          height: height,
          heightUnit: heightUnit,
        ),
      ),
    );
  }

  void saveWeight({required num weight, required WeightUnit weightUnit}) {
    emit(
      state.copyWith(
        userSetup: state.userSetup.copyWith(
          weight: weight,
          weightUnit: weightUnit,
        ),
      ),
    );
  }

  void saveTargetWeight({
    required num targetWeight,
    required WeightUnit targetWeightUnit,
  }) {
    emit(
      state.copyWith(
        userSetup: state.userSetup.copyWith(
          targetWeight: targetWeight,
          targetWeightUnit: targetWeightUnit,
        ),
      ),
    );
  }

  void saveFitnessGoal({required FitnessGoal fitnessGoal}) {
    emit(
      state.copyWith(
        userSetup: state.userSetup.copyWith(fitnessGoal: fitnessGoal),
      ),
    );
  }

  void saveLevels({required Levels levels}) {
    emit(state.copyWith(userSetup: state.userSetup.copyWith(levels: levels)));
  }

  void saveExerciseLocation({required ExerciseLocation exerciseLocation}) {
    emit(
      state.copyWith(
        userSetup: state.userSetup.copyWith(exerciseLocation: exerciseLocation),
      ),
    );
  }

  void saveExerciseDuration({required ExerciseDuration exerciseDuration}) {
    emit(
      state.copyWith(
        userSetup: state.userSetup.copyWith(exerciseDuration: exerciseDuration),
      ),
    );
  }

  void saveWeekDay({required Set<WeekDay> weekDay}) {
    emit(state.copyWith(userSetup: state.userSetup.copyWith(weekDay: weekDay)));
  }

  void saveActivityLevel({required ActivityLevel activityLevel}) {
    emit(
      state.copyWith(
        userSetup: state.userSetup.copyWith(activityLevel: activityLevel),
      ),
    );
  }

  Future submitGender({
    required GenderType gender,
    required int currantPage,
  }) async {
    emit(state.copyWith(status: SetupStatus.loading));
    final data = await getIt.get<UserDataSources>().gander(
      gender.name,
      currantPage,
    );
    data.fold(
      (l) {
        emit(state.copyWith(status: SetupStatus.failure));
        emit(state.copyWith(errorMessage: l));
      },
      (r) {
        emit(state.copyWith(status: SetupStatus.success));
        emit(state.copyWith(successMessage: r));
      },
    );
  }

  Future submitBodyData({
    required num height,
    required num weight,
    required num targetWeight,
    required HeightUnit heightUnit,
    required WeightUnit weightUnit,
    required WeightUnit tWeightUnit,
    required int age,
    required int pageComplete,
  }) async {
    emit(state.copyWith(status: SetupStatus.loading));

    final data = await getIt.get<UserDataSources>().userBody(
      weight,
      height,
      age,
      weightUnit.name,
      heightUnit.name,
      tWeightUnit.name,
      targetWeight,
      pageComplete,
    );
    data.fold(
      (l) {
        emit(state.copyWith(status: SetupStatus.failure));
        emit(state.copyWith(errorMessage: l));
      },
      (r) {
        emit(state.copyWith(status: SetupStatus.success));
        emit(state.copyWith(successMessage: r));
      },
    );
    ;
  }

  Future submitExerciseInfo({
    required ActivityLevel activityLevel,
    required Set<WeekDay> weekDay,
    required ExerciseDuration exerciseDuration,
    required ExerciseLocation exerciseLocation,
    required int pageComplete,
  }) async {
    emit(state.copyWith(status: SetupStatus.loading));
    final data = await getIt.get<UserDataSources>().exerciseInfo(
      exerciseLocation.name,
      weekDay.toList(),
      exerciseDuration.name,
      pageComplete,
      activityLevel.name,
    );
    data.fold(
      (l) {
        emit(state.copyWith(status: SetupStatus.failure));
        emit(state.copyWith(errorMessage: l));
      },
      (r) {
        emit(state.copyWith(status: SetupStatus.success));
        emit(state.copyWith(successMessage: r));
      },
    );
  }

  Future submitGoal({
    required FitnessGoal fitnessGoal,
    required Levels levels,
    required int pageComplete,
  }) async {
    emit(state.copyWith(status: SetupStatus.loading));
    final data = await getIt.get<UserDataSources>().userGoals(
      levels.name,
      fitnessGoal.name,
      pageComplete,
    );
    data.fold(
      (l) {
        emit(state.copyWith(status: SetupStatus.failure));
        emit(state.copyWith(errorMessage: l));
      },
      (r) {
        emit(state.copyWith(status: SetupStatus.success));
        emit(state.copyWith(successMessage: r));
      },
    );
  }

  Future getUserSetupData() async {
    emit(state.copyWith(status: SetupStatus.dataLoading));
    final data = await userSetupRepository.getUserSetupData();

    data.fold(
      (l) {
        emit(state.copyWith(status: SetupStatus.failure));
        emit(state.copyWith(errorMessage: l));
      },
      (r) {
        emit(state.copyWith(status: SetupStatus.success));
        emit(state.copyWith(userSetup: r));
      },
    );
  }

  Future submitExtraUserData({
    required num bmi,
    required num targetBmi,
    required num bmr,
    required num tdee,
    required num targetCalories,
    required num weightDifference,
    required num weightChangePercentage,
  }) async {
    final data = await userSetupRepository.userDataSources.updateUserDataBody(
      bmi,
      bmr,
      tdee,
      targetCalories,
      weightDifference,
      weightChangePercentage,
      targetBmi,
    );
    data.fold(
      (l) {
        emit(state.copyWith(status: SetupStatus.failure));
        emit(state.copyWith(errorMessage: l));
      },
      (r) {
        emit(state.copyWith(status: SetupStatus.success));
        emit(state.copyWith(successMessage: r));
      },
    );
  }

  Future updateSetupComplete({required bool isComplete}) async {
    emit(state.copyWith(status: SetupStatus.loading));
    final data = await getIt.get<UserDataSources>().isSetupComplete(isComplete);
    data.fold(
      (l) {
        emit(state.copyWith(status: SetupStatus.failure));
        emit(state.copyWith(errorMessage: l));
      },
      (r) {
        emit(state.copyWith(status: SetupStatus.success));
        emit(state.copyWith(successMessage: r));
      },
    );
  }
}
