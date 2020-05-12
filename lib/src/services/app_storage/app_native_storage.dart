import 'package:shared_preferences/shared_preferences.dart';
import 'package:vockify/src/services/app_storage/app_storage_interface.dart';

class AppNativeStorage extends AppStorageInterface {
  @override
  Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  @override
  Future<String> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  @override
  Future<void> setValue(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
