import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'AccessToken', value: token);
  }

  Future<String?> getAccessToken() {
    return _storage.read(key: 'AccessToken');
  }

  Future<void> saveUid(String Uid) async {
    await _storage.write(key: 'Uid', value: Uid);
  }

  Future<String?> getUid() {
    return _storage.read(key: 'Uid');
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }
}
