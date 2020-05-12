import 'package:flutter/foundation.dart';
import 'package:vockify/src/services/app_storage/app_cookie_storage.dart';
import 'package:vockify/src/services/app_storage/app_native_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_interface.dart';

class AppStorage extends AppStorageInterface {
  static AppStorageInterface _instance;

  @override
  Future<bool> containsKey(String key) => _instance.containsKey(key);

  @override
  Future<String> getValue(String key) => _instance.getValue(key);

  @override
  Future<void> remove(String key) => _instance.remove(key);

  @override
  Future<void> setValue(String key, String value) => _instance.setValue(key, value);

  static AppStorageInterface getInstance() {
    if (_instance == null) {
      if (kIsWeb) {
        _instance = AppCookieStorage();
      } else {
        _instance = AppNativeStorage();
      }
    }

    return _instance;
  }
}
