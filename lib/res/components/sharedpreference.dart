import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass {
  writeTheData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    }
  }

  readTheData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  deleteTheData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clearTheData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}