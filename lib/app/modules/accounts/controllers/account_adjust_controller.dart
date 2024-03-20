import 'package:get/get.dart';
import 'package:formz/formz.dart';
import '/app/modules/flows/controllers/flow_detail_controller.dart';
import '../../../core/utils/message.dart';
import '/app/modules/accounts/controllers/account_detail_controller.dart';
import '/app/modules/accounts/controllers/accounts_controller.dart';
import '/app/core/commons/form/not_empty_num_formz.dart';
import '/app/core/base/base_controller.dart';
import '../../login/controllers/auth_controller.dart';
import '../data/account_repository.dart';


class AccountAdjustController extends BaseController {

  bool valid = false;
  Map<String, dynamic> form = { };
  NotEmptyNumFormz balanceFormz = const NotEmptyNumFormz.pure();

  int action;
  Map<String, dynamic> currentRow;

  AccountAdjustController(this.action, this.currentRow);

  @override
  void onInit() {
    super.onInit();
    if (action == 1) {
      form['createTime'] = DateTime.now().millisecondsSinceEpoch;
      form['book'] = Get.find<AuthController>().initState['book'];
    } else {
      valid = true;
      form['book'] = currentRow['book'];
      form['title'] = currentRow['title'];
      form['createTime'] = currentRow['createTime'];
      form['notes'] = currentRow['notes'];
    }

  }

  void balanceChanged(String value) {
    balanceFormz = NotEmptyNumFormz.dirty(value: value);
    valid = Formz.validate([balanceFormz]);
    form['balance'] = value;
    update();
  }

  void submit() async {
    if (valid) {
      try {
        Message.showLoading();
        bool result = false;
        Map<String, dynamic> newForm = { ...form };
        if (form['book']?['value'] != null) {
          newForm['book'] = form['book']?['value'];
        }
        switch (action) {
          case 1:
            result = await AccountRepository.createAdjust(currentRow['id'], newForm);
            break;
          case 2:
            result = await AccountRepository.updateAdjust(currentRow['id'], newForm);
            break;
        }
        if (result) {
          Get.back();
          if (action == 1) {
            // 更新成功要刷新列表页和详情页
            Get.find<AccountsController>().reload();
            Get.find<AccountDetailController>().load();
          } else {
            Get.find<FlowDetailController>().load();
          }
        }
      } catch (_) {
        _.printError();
      }
    }
  }


}