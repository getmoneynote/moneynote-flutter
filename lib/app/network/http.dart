import '/app/core/values/app_values.dart';
import '/app/network/http_client.dart';

class Http {

  static Future<Map<String, dynamic>> get(String uri, {Map<String, dynamic>? params}) async {
    return (await HttpClient().get('${AppValues.apiUrl}/api/v1/$uri', params: params));
  }

  static Future<Map<String, dynamic>> post(String uri, {data}) async {
    return (await HttpClient().post('${AppValues.apiUrl}/api/v1/$uri', data: data));
  }

  static Future<Map<String, dynamic>> patch(String uri, {data}) async {
    return (await HttpClient().patch('${AppValues.apiUrl}/api/v1/$uri', data: data));
  }

  static Future<Map<String, dynamic>> delete(String uri) async {
    return (await HttpClient().delete('${AppValues.apiUrl}/api/v1/$uri'));
  }

  static Future<Map<String, dynamic>> put(String uri, {data}) async {
    return (await HttpClient().put('${AppValues.apiUrl}/api/v1/$uri', data: data));
  }

  static void init() {
    HttpClient().init();
  }

}