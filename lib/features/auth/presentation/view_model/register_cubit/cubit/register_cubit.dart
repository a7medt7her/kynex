import 'package:bloc/bloc.dart';
import 'package:kynex/core/helper/auth_helper.dart';
import 'package:kynex/core/helper/create_user.dart';
import 'package:kynex/core/helper/secure_storage_service.dart';
import 'package:kynex/core/services/app_dependencies.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  bool visibility = true;
  bool visibility2 = true;
  Future register(String email, String password) async {
    emit(RegisterLoading());
    final data = await getIt.get<AuthHelper>().register(email, password);
    data.fold(
      (l) {
        emit(RegisterError(message: l));
      },
      (r) {
        emit(RegisterSuccess(message: r));
      },
    );
  }

  void isVisibility() {
    visibility = !visibility;
    emit(Visibility());
  }

  Future<void> saveUser(
    String email,
    String username,
    bool isSetup,
    DateTime createdAt,
  ) async {
    emit(SaveUserLoading());
    try {
      final uid = await getIt.get<SecureStorageService>().getUid();
      if (uid == null) {
        emit(SaveUserError(message: 'User UID not found'));
        return;
      }
      await getIt.get<CreateUser>().addUserData(
        uid,
        username,
        email,
        isSetup,
        createdAt,
      );
      emit(SaveUserSuccess());
    } catch (e) {
      emit(SaveUserError(message: e.toString()));
    }
  }

  void isVisibility2() {
    visibility2 = !visibility2;
    emit(Visibility());
  }
}
