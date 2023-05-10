import '/commons/index.dart';

class ChartRepository {

  static Future<List<List<Map<String, dynamic>>>> balance() async {
    dynamic data = (await HttpClient().get('/reports/balance'))['data'];
    return [List<Map<String, dynamic>>.from(data[0]), List<Map<String, dynamic>>.from(data[1])];
  }

  static Future<List<Map<String, dynamic>>> expenseCategory(Map<String, dynamic> form) async {
    dynamic data = (await HttpClient().get('/reports/expense-category', params: form))['data'];
    return List<Map<String, dynamic>>.from(data);
  }

  static Future<List<Map<String, dynamic>>> incomeCategory(Map<String, dynamic> form) async {
    dynamic data = (await HttpClient().get('/reports/income-category', params: form))['data'];
    return List<Map<String, dynamic>>.from(data);
  }

}