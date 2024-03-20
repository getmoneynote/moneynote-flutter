import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../modules/accounts/controllers/accounts_controller.dart';
import '../../modules/flows/controllers/flows_controller.dart';
import '../../modules/my/controllers/account_overview_controller.dart';
import '/generated/locales.g.dart';

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
      return LocaleKeys.account_checking.tr;
    case 'CREDIT':
      return LocaleKeys.account_credit.tr;
    case 'ASSET':
      return LocaleKeys.account_asset.tr;
    case 'DEBT':
      return LocaleKeys.account_debt.tr;
  }
  throw Exception('tab index error');
}

String flowTypeToName(String type) {
  switch (type) {
    case 'EXPENSE':
      return LocaleKeys.flow_type1.tr;
    case 'INCOME':
      return LocaleKeys.flow_type2.tr;
    case 'TRANSFER':
      return LocaleKeys.flow_type3.tr;
    case 'ADJUST':
      return LocaleKeys.flow_type4.tr;
  }
  throw Exception('error');
}

String translateAction(int action) {
  switch (action) {
    case 1:
      return LocaleKeys.common_new.tr;
    case 2:
      return LocaleKeys.common_edit.tr;
    case 3:
      return LocaleKeys.common_copy.tr;
    case 4:
      return LocaleKeys.flow_refund.tr;
  }
  throw Exception('action error');
}

String boolToString(bool val) {
  if (val) {
    return LocaleKeys.common_yes.tr;
  } else {
    return LocaleKeys.common_no.tr;
  }
}

String hasToString(bool val) {
  if (val) {
    return LocaleKeys.common_has.tr;
  } else {
    return LocaleKeys.common_none.tr;
  }
}

bool isNullEmpty(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || "" == o;
}

String removeDecimalZero(num? n) {
  if (n == null) return '';
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  return n.toString().replaceAll(regex, "");
}

String dateFormatStr1() {
  String locale = Get.locale?.toString() ?? '';
  if (locale == 'en_US') {
    return 'MM/dd/yyyy HH:mm';
  } else if (locale == 'zh_CN') {
    return 'yyyy-MM-dd HH:mm';
  }
  return 'MM/dd/yyyy HH:mm';
}

String dateFormatStr2() {
  String locale = Get.locale?.toString() ?? '';
  if (locale == 'en_US') {
    return 'MM/dd/yyyy';
  } else if (locale == 'zh_CN') {
    return 'yyyy-MM-dd';
  }
  return 'MM/dd/yyyy';
}

String dateTimeFormat(int? timestamp) {
  if (timestamp == null) return '';
  return DateFormat(dateFormatStr1()).format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}

String dateFormat(int? timestamp) {
  if (timestamp == null) return '';
  return DateFormat(dateFormatStr2()).format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}

void reloadState() {
  if (Get.isRegistered<FlowsController>()) {
    Get.find<FlowsController>().reset();
    Get.find<FlowsController>().reload();
  }
  if (Get.isRegistered<AccountsController>()) {
    Get.find<AccountsController>().reload();
  }
  if (Get.isRegistered<AccountOverviewController>()) {
    Get.find<AccountOverviewController>().load();
  }
}

bool validAmount(String? value) {
  if (value?.isEmpty ?? true) {
    return false;
  }
  RegExp regex = RegExp(r'(^-?\d{1,9}(\.\d{0,2})?$)');
  return regex.hasMatch(value!);
}