import 'package:shared_preferences/shared_preferences.dart';

class Token {

  static Future<bool> save(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('accessToken', token);
  }

  static Future<String> get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') ?? '';
  }

  static Future<bool> delete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove('accessToken');
  }

}