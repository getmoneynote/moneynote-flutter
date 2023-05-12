import '/commons/index.dart';

class FlowRepository {

  static Future<bool> deleteWithAccount(int id) async {
    return (await HttpClient().delete('balance-flows/$id/deleteWithAccount'))['success'];
  }

}