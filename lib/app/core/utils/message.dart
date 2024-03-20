import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:moneynote/generated/locales.g.dart';

class Message {

  static success(String msg) {
    EasyLoading.showSuccess(msg, duration: const Duration(seconds: 2));
  }

  static error(String msg) {
    EasyLoading.showError(msg, duration: const Duration(seconds: 2));
  }

  static showLoading({String? msg}) {
    EasyLoading.show(status: msg ?? LocaleKeys.common_loading.tr, maskType: EasyLoadingMaskType.black);
  }

  static disLoading() {
    EasyLoading.dismiss();
  }

}