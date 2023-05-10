import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoadDataStatus { initial, progress, success, empty, failure }

const String pageParameter = 'current';
const String sortParameter = 'sort';
const String pageSizeParameter = 'pageSize';
const int defaultPageSize = 10;

String accountTabIndexToType(int index) {
  switch (index) {
    case 0:
      return 'CHECKING';
    case 1:
      return 'CREDIT';
    case 2:
      return 'ASSET';
    case 3:
      return 'DEBT';
  }
  throw Exception('tab index error');
}

String accountTypeToName(String type) {
  switch (type) {
    case 'CHECKING':
      return '活期账户';
    case 'CREDIT':
      return '信用账户';
    case 'ASSET':
      return '资产账户';
    case 'DEBT':
      return '贷款账户';
  }
  throw Exception('account type error');
}

String flowTabIndexToType(int index) {
  switch (index) {
    case 0:
      return 'EXPENSE';
    case 1:
      return 'INCOME';
    case 2:
      return 'TRANSFER';
    case 3:
      return 'ADJUST';
  }
  throw Exception('tab index error');
}

String translateFlowType(String type) {
  switch (type) {
    case 'EXPENSE':
      return '支出';
    case 'INCOME':
      return '收入';
    case 'TRANSFER':
      return '转账';
    case 'ADJUST':
      return '余额调整';
  }
  throw Exception('flow type error');
}

String translateAction(int action) {
  switch (action) {
    case 1:
      return '新增';
    case 2:
      return '修改';
    case 3:
      return '复制';
    case 4:
      return '退款';
  }
  throw Exception('action error');
}

String dateFormat(int? timestamp) {
  if (timestamp == null) return '';
  return DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}

String dateTimeFormat(int? timestamp) {
  if (timestamp == null) return '';
  return DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}

String boolToString(bool val) {
  if (val) {
    return '是';
  } else {
    return '否';
  }
}

Future<bool> saveToken(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('accessToken', token);
}

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken') ?? '';
}

Future<bool> deleteToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.remove('accessToken');
}

String removeDecimalZero(num? n) {
  if (n == null) return '';
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  return n.toString().replaceAll(regex, "");
}

bool validAmount(String? value) {
  if (value?.isEmpty ?? true) {
    return false;
  }
  RegExp regex = RegExp(r'(^-?\d{1,9}(\.\d{0,2})?$)');
  return regex.hasMatch(value!);
}

bool isNullEmpty(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || "" == o;
}