// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final _storage = FlutterSecureStorage();

  Future<void> storeString({required String key, required String? value}) async =>
      await _storage.write(key: key, value: value);

  Future<void> storeInt ({required String key, required int? value}) async {
    if (value != null) await _storage.write(key: key, value: value.toString());
  }

  Future<String?> getStringValue({required String key}) async =>
      await _storage.read(key: key);

  Future<int?> getIntValue({required String key}) async {
    String? data= await _storage.read(key: key);
    return data != null ? int.parse(data) : null;
  }

  Future delete({required String key}) async => 
      await _storage.delete(key: key);
}
