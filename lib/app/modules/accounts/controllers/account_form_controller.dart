import 'package:formz/formz.dart';
import 'package:get/get.dart';
import '/app/core/utils/message.dart';
import '/app/core/base/base_repository.dart';
import '/app/core/utils/utils.dart';
import '/app/core/commons/form/not_empty_formz.dart';
import '/app/core/commons/form/not_empty_num_formz.dart';
import '../../login/controllers/auth_controller.dart';
import '/app/core/base/base_controller.dart';
import 'account_detail_controller.dart';
import 'accounts_controller.dart';

class AccountFormController extends BaseController {

  bool valid = false;
  Map<String, dynamic> form = { };
  NotEmptyFormz nameFormz = const NotEmptyFormz.pure();
  NotEmptyNumFormz balanceFormz = const NotEmptyNumFormz.pure();

  String type;
  int action;
  Map<String, dynamic> currentRow;

  AccountFormController(this.type, this.action, this.currentRow);

  @override
  void onInit() {
    super.onInit();
    reset();
  }

  void reset() {
    valid = action != 1;
    if (action == 2) {
      form = { ...currentRow };
      nameFormz = NotEmptyFormz.dirty(value: currentRow['name']);
      balanceFormz = NotEmptyNumFormz.dirty(value: removeDecimalZero(currentRow['balance']));
    }
    if (action == 1) {
      form = {};
      form['currencyCode'] = Get.find<AuthController>().initState['group']['defaultCurrencyCode'];
      form['canExpense'] = true;
      form['canIncome'] = true;
      form['canTransferFrom'] = true;
      form['canTransferTo'] = true;
      form['include'] = true;
    }
    update();
  }

  void submit() async {
    if (valid) {
      try {
        Message.showLoading();
        bool result = false;
        switch (action) {
          case 1:
            result = await BaseRepository.add('accounts', {
              ...form,
              'type': type
            });
            break;
          case 2:
            result = await BaseRepository.update('accounts', currentRow['id'], form);
            break;
        }
        if (result) {
          Get.back();
          Get.find<AccountsController>().reload();
          Get.find<AccountDetailController>().load();
        }
      } catch (_) {
        _.printError();
      } finally {
        // Message.disLoading();
      }
    }
  }

  void changeCurrency(dynamic value) {
    form['currencyCode'] = value;
    update();
    Get.back();
  }

  void changeName(String value) {
    nameFormz = NotEmptyFormz.dirty(value: value);
    valid = Formz.validate([nameFormz, balanceFormz]);
    form['name'] = value;
    update();
  }

  void changeBalance(String value) {
    balanceFormz = NotEmptyNumFormz.dirty(value: value);
    valid = Formz.validate([nameFormz, balanceFormz]);
    form['balance'] = value;
    update();
  }

  void changeType(String value) {
    type = value;
    update();
    if(Get.isBottomSheetOpen ?? false){
      Get.back();
    }
  }

}