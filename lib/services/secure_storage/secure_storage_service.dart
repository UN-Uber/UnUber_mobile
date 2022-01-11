// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final _storage = FlutterSecureStorage();

  Future<void> store({required String key, required String? value}) async =>
      await _storage.write(key: key, value: value);

  Future<String?> getValue({required String key}) async =>
      await _storage.read(key: key);

  Future delete({required String key}) async => 
      await _storage.delete(key: key);
}
