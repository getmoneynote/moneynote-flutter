import '/commons/index.dart';

class MyRepository {

  static Future<List<num>> balanceView() async {
    dynamic data = (await HttpClient().get('/accounts/overview'))['data'];
    return List<num>.from(data);
  }

}