import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kynex/core/helper/firebase_handel.dart';
import 'package:kynex/core/helper/secure_storage_service.dart';
import 'package:kynex/core/services/app_dependencies.dart';

class AuthHelper {
  Future<Either<String, String>> register(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await getIt.get<SecureStorageService>().saveUid(credential.user!.uid);
      return right('Welcome');
    } catch (e) {
      return left(fireBaseHandel(e));
    }
  }

  Future<Either<String, String>> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await getIt.get<SecureStorageService>().saveUid(credential.user!.uid);
      return right('hi');
    } catch (e) {
      return left(fireBaseHandel(e));
    }
  }

  final signOut = FirebaseAuth.instance.signOut();
}
