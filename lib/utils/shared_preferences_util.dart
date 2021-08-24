import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static late SharedPreferencesUtil _storageUtil;
  static late SharedPreferences _preferences;
  SharedPreferencesUtil._();
  static Future<SharedPreferencesUtil?> getInstance() async {
    var secureStorage = SharedPreferencesUtil._();
    await secureStorage._init();
    _storageUtil = secureStorage;
    // if (_storageUtil == null) {
    //   var secureStorage = SharedPreferencesUtil._();
    //   await secureStorage._init();
    //   _storageUtil = secureStorage;
    // }
    return _storageUtil;
  }

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // put string
  static Future<bool> putString(String? key, String? value) {
    // if (_preferences == null) return null;
    return _preferences.setString(key!, value!);
  }

  // get string
  static String getString(String? key, {String defValue = ''}) {
    // if (_preferences == 'null') return defValue;
    return _preferences.getString(key!) ?? defValue;
  }

  // set double
  static Future<bool> putDouble(String? key, double? value) {
    // if (_preferences == null) return null;
    return _preferences.setDouble(key!, value!);
  }

  // get double
  static double getDouble(String? key, {double defValue = 0}) {
    // if (_preferences == null) return defValue;
    return _preferences.getDouble(key!) ?? defValue;
  }

  // set int
  static Future<bool> putInt(String? key, int? value) {
    return _preferences.setInt(key!, value!);
  }

  // get int
  static int getInt(String? key, {int defValue = 0}) {
    // if (_preferences == null) return defValue;
    return _preferences.getInt(key!) ?? defValue;
  }

  //set bool
  static Future<bool> putBool(String? key, bool? value) {
    // if (_preferences == null) return null;
    return _preferences.setBool(key!, value!);
  }

  // get bool
  static bool getBool(String? key, {bool defValue = false}) {
    // if (_preferences == null) return defValue;
    return _preferences.getBool(key!) ?? defValue;
  }

  // clear string
  static Future<void> clear() async {
    SharedPreferences prefs = _preferences;
    prefs.clear();
  }

  static Future<bool> commit() async => true;
}
