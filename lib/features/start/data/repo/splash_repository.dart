import 'package:dartz/dartz.dart';
import 'package:kynex/core/helper/firebase_handel.dart';
import 'package:kynex/features/start/data/data_source/splash_data_source.dart';

class SplashRepository {
  SplashDataSource splashDataSource;
  SplashRepository({required this.splashDataSource});
  Future<Either<String, Map<String, dynamic>>> getUserSetupData() async {
    try {
      final data = await splashDataSource.getUserdata();

      return right(data);
    } catch (e) {
      return left(fireBaseHandel(e));
    }
  }
}
