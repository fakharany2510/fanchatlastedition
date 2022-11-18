import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPreferences;

  static init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static Future<bool> saveData({required String key, dynamic value}) async {
    if (value is String) return sharedPreferences!.setString(key, value);
    if (value is bool) return sharedPreferences!.setBool(key, value);
    if (value is int) return sharedPreferences!.setInt(key, value);

    return sharedPreferences!.setDouble(key, value);
  }

  static dynamic getData({required String key}) => sharedPreferences!.get(key);

  static Future<bool> removeData({required String key}) async =>
      await sharedPreferences!.remove(key);
}
