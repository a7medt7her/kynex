import 'package:get_it/get_it.dart';
import 'package:kynex/core/helper/auth_helper.dart';
import 'package:kynex/core/helper/create_user.dart';
import 'package:kynex/core/helper/dio_helper.dart';
import 'package:kynex/core/helper/secure_storage_service.dart';

final getIt = GetIt.instance;
void setupServices() {
  getIt.registerLazySingleton<DioHelper>(() => DioHelper());
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );
  getIt.registerLazySingleton<AuthHelper>(() => AuthHelper());
  getIt.registerLazySingleton<CreateUser>(() => CreateUser());
}
