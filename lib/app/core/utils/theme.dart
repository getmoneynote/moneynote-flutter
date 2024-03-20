import 'package:shared_preferences/shared_preferences.dart';

class Theme {

  static Future<bool> save(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('theme', theme);
  }

  static Future<String> get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme') ?? '';
  }

}