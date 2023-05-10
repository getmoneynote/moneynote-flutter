import '/commons/index.dart';

class AccountRepository {

  static Future<bool> createAdjust(int id, Map<String, dynamic> form) async {
    return (await HttpClient().post('accounts/$id/adjust', data: form))['success'];
  }

  static Future<bool> updateAdjust(int id, Map<String, dynamic> form) async {
    return (await HttpClient().put('accounts/$id/adjust', data: form))['success'];
  }

}