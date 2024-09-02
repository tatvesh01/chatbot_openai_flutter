import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
      prefs.setBool(key, value);
  }

  static Future<bool> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bool obj = prefs.getBool(key) ?? false;
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

class SavedStatusEvent {
  SavedStatusEvent();
}