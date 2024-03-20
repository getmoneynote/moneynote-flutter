import '/app/network/http.dart';

class LoginRepository {

  static Future<String> logIn({
    required String username,
    required String password
  }) async {
    Map<String, dynamic> response = await Http.post('login', data: {'username': username, 'password': password});
    if (response['success']) {
      return response['data']['accessToken'];
    } else {
      throw Exception('Login Failed');
      // return Future.error('Login Failed');
    }
  }

  static Future<Map<String, dynamic>> getInitState() async {
    return (await Http.get('initState'))['data'];
  }

}