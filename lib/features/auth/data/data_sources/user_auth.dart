import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kynex/core/helper/firebase_handel.dart';
import 'package:kynex/core/helper/secure_storage_service.dart';
import 'package:kynex/core/services/app_dependencies.dart';

class UserAuth {
  Future<String> _getUid() async {
    final uid = await getIt.get<SecureStorageService>().getUid();

    if (uid == null || uid.isEmpty) {
      throw Exception('User UID not found');
    }

    return uid;
  }

  Future<void> addUserData(
    String username,
    String email,
    bool isSetup,
    DateTime createdAt,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      final uid = await _getUid();
      await users.doc(uid).set({
        'userName': username,
        'email': email,
        'isComplete': isSetup,
        'createdAt': createdAt,
      });
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
      fireBaseHandel(e);
    }
  }
}
