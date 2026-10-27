import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kynex/core/helper/secure_storage_service.dart';
import 'package:kynex/core/services/app_dependencies.dart';

class SplashDataSource {
  Future<String> _getUid() async {
    final uid = await getIt.get<SecureStorageService>().getUid();

    if (uid == null || uid.isEmpty) {
      throw Exception('User UID not found');
    }

    return uid;
  }

  Future<Map<String, dynamic>> getUserdata() async {
    final uid = await _getUid();
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (!userDoc.exists) {
      throw Exception('data not founded');
    }
    final Map<String, dynamic>? data = userDoc.data();
    if (data == null) {
      throw Exception('User data is empty');
    }

    return data;
  }
}
