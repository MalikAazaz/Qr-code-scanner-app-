import 'package:shared_preferences/shared_preferences.dart';

class HistoryManager {
  static const String key = "qr_history";

  static Future<void> save(String data) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(key) ?? [];
    list.insert(0, data);
    await prefs.setStringList(key, list);
  }

  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  static Future<void> delete(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(key) ?? [];
    list.removeAt(index);
    await prefs.setStringList(key, list);
  }
}
