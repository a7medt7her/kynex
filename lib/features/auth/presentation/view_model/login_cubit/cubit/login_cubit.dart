import 'package:bloc/bloc.dart';
import 'package:kynex/core/helper/auth_helper.dart';
import 'package:kynex/core/services/app_dependencies.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  bool visibility = true;
  Future login(String email, String password) async {
    emit(LoginLoading());
    final data = await getIt.get<AuthHelper>().login(email, password);
    data.fold(
      (l) {
        emit(LoginError(massage: l));
      },
      (r) {
        emit(LoginSuccess(massage: r));
      },
    );
  }

  void isVisibility() {
    visibility = !visibility;
    emit(Visibility());
  }
}
