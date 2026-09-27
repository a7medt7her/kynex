import 'package:bloc/bloc.dart';
import 'package:kynex/core/helper/create_user.dart';
import 'package:kynex/core/helper/fitness_calculations.dart';
import 'package:kynex/core/helper/secure_storage_service.dart';
import 'package:kynex/core/services/app_dependencies.dart';
import 'package:meta/meta.dart';

part 'gander_state.dart';

class GanderCubit extends Cubit<GanderState> {
  GanderCubit() : super(GanderInitial());

  GenderType? ganderSelected;
  int page = 0;
  Future<void> saveUser(String gander) async {
    emit(SaveDataLoading());
    try {
      final uid = await getIt.get<SecureStorageService>().getUid();
      if (uid == null) {
        emit(SaveDataError(massage: 'Error user Id'));
        return;
      }
      await getIt.get<CreateUser>().gander(uid, gander, page);
      emit(SaveDataSuccess());
    } catch (e) {
      emit(SaveDataError(massage: e.toString()));
    }
  }

  void ganderSelect(GenderType gander) {
    ganderSelected = gander;
    emit(GanderSelected());
  }
}
