import 'package:dartz/dartz.dart';
import 'package:kynex/core/helper/firebase_handel.dart';
import 'package:kynex/features/setup_profile/data/data_sources/user_data_sources.dart';
import 'package:kynex/features/setup_profile/data/model/uer_setup_model.dart';

class UserSetupRepository {
  UserDataSources userDataSources;
  UserSetupRepository({required this.userDataSources});
  Future<Either<String, UserSetupModel>> getUserSetupData() async {
    try {
      final data = await userDataSources.getUserdata();
      final user = UserSetupModel.fromJson(data);
      return right(user);
    } catch (e, v) {
      print(e);
      print(v);
      return left(fireBaseHandel(e));
    }
  }
}
