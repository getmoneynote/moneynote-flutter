import '/commons/index.dart';
import '/login/index.dart';

class LoginRepository {

  static Future<String> logIn({
    required String username,
    required String password
  }) async {
    Map<String, dynamic> response = await HttpClient().post('login', data: {'username': username, 'password': password});
    if (response['success']) {
      return response['data']['accessToken'];
    } else {
      throw Exception('Login Failed');
      // return Future.error('Login Failed');
    }
  }

  static Future<Map<String, dynamic>> getInitState() async {
    return (await HttpClient().get('initState'))['data'];
  }

  static Future<String> wechatCallBack({
    required String code,
    required String state
  }) async {
    Map<String, dynamic> response = await HttpClient().get('loginWechat/appCallback', params: {'code': code, 'state': state});
    if (response['success']) {
      return response['data'];
    } else {
      throw Exception('Login Failed');
      // return Future.error('Login Failed');
    }
  }


}