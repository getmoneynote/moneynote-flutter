import 'package:shared_preferences/shared_preferences.dart';

class Language {

  static Future<bool> save(String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('lang', lang);
  }

  static Future<String> get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('lang') ?? '';
  }

}