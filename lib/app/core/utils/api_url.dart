import 'package:shared_preferences/shared_preferences.dart';
import '/app/core/values/app_values.dart';
import '/app/network/http_client.dart';

class ApiUrl {

  static Future<bool> save(String url) async {
    AppValues.apiUrl = url;
    HttpClient().init();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('apiUrl', url);
  }

  static Future<String> get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String apiUrl = prefs.getString('apiUrl') ?? '';
    if (apiUrl.isNotEmpty) {
      AppValues.apiUrl = apiUrl;
    }
    return apiUrl;
  }

}