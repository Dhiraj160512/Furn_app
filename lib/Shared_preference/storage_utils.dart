import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static StorageUtils? _storageUtils;
  static SharedPreferences? _preferences;

  static Future<StorageUtils?> getInstance() async {
    if (_storageUtils == null) {
      var secureStorage = StorageUtils._();
      await secureStorage._init();
      _storageUtils = secureStorage;
    }
    return _storageUtils;
  }

  StorageUtils._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Get string
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) {
      return defValue;
    }
    return _preferences!.getString(key) ?? defValue;
  }

  // Put string
  static Future<bool> putString(String key, String value) async {
    if (_preferences == null) {
      await getInstance();
    }
    return _preferences!.setString(key, value);
  }

  // get bool
  static bool getBool(String key, {bool defValue = false}) {
    if (_preferences == null) return defValue;
    return _preferences!.getBool(key) ?? defValue;
  }

  // put bool
  static Future<bool> putBool(String key, bool value) {
    if (_preferences == null) return Future.value(false);
    return _preferences!.setBool(key, value);
  }

  // Remove a specific key
  static Future<bool> remove(String key) async {
    return _preferences?.remove(key) ?? Future.value(false);
  }

  //clearstring
  static Future<bool> clearAll() {
    if (_preferences == null) return Future.value(false);
    return _preferences!.clear();
  }
}
