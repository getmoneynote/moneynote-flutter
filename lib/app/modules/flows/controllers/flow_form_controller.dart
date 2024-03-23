import 'package:get/get.dart';
import 'dart:convert';
import '../../../core/utils/utils.dart';
import '../../../network/http.dart';
import '/app/core/base/base_repository.dart';
import '/app/modules/flows/controllers/flow_detail_controller.dart';
import '../../../core/utils/message.dart';
import '../../login/controllers/auth_controller.dart';
import '/app/core/base/base_controller.dart';
import 'flows_controller.dart';

class FlowFormController extends BaseController {

  bool valid = false;
  Map<String, dynamic> form = { };
  List<dynamic> categories = [];

  String type;
  int action;
  Map<String, dynamic> currentRow;

  FlowFormController(this.type, this.action, this.currentRow);

  @override
  void onInit() {
    super.onInit();
    reset();
  }

  void reset() {
    form = { };
    // 必须加上，否则form['categories'].firstWhere报错
    form['categories'] = [];
    form['createTime'] = action != 2 ? DateTime.now().millisecondsSinceEpoch : currentRow['createTime'];
    form['confirm'] = action != 2 ? true : currentRow['confirm'];
    form['include'] = action != 2 ? true : currentRow['include'];
    form['notes'] = action != 2 ? null : currentRow['notes'];
    Map<String, dynamic> initBook = Get.find<AuthController>().initState['book'];
    if (action == 1) {
      form['book'] = initBook;
      // 初始化新增的Account
      // 初始化转账的转入账户
      _loadAccountByBook(initBook);
      // 初始化新增的分类
      _loadCategoryByBook(initBook);
    } else {
      form['book'] = currentRow['book'];
      form['title'] = currentRow['title'];
      form['account'] = currentRow['account'];
      if (type == 'EXPENSE' || type == 'INCOME') {
        categories = currentRow['categories'].map((e) => e['category']).toList();
        form['categories'] = currentRow['categories'].map((e) => {
          'category': e['categoryId'],
          'categoryName': e['categoryName'],
          'amount': action != 4 ? e['amount'] : e['amount'] * -1,
          'convertedAmount': action != 4 ? e['convertedAmount'] : e['convertedAmount'] * -1,
        }).toList();
        form['payee'] = currentRow['payee'];
      }
      if (type == 'TRANSFER') {
        form['amount'] = currentRow['amount'];
        form['convertedAmount'] = currentRow['convertedAmount'];
        if (action == 4) {
          form['account'] = currentRow['to'];
          form['to'] = currentRow['account'];
        } else {
          form['to'] = currentRow['to'];
        }
      }
      form['tags'] = currentRow['tags'].map((e) => e['tag']).toList();
    }
    valid = _checkValid();
    update();
  }

  void submit() async {
    if (valid) {
      try {
        Message.showLoading();
        if (action == 2) {
          var res = await BaseRepository.update2('balance-flows', currentRow['id'], buildForm());
          Get.find<FlowsController>().reload();
          Get.back();
          Get.find<FlowDetailController>().setId(res['data']);
          Get.find<FlowDetailController>().load();
          Message.disLoading();
        } else {
          bool result = await BaseRepository.add('balance-flows', buildForm());
          if (result) {
            Get.back();
            Get.find<FlowsController>().reload();
            Get.find<FlowDetailController>().load();
          }
        }
      } catch (_) {
        _.printError();
      } finally {
        // Message.disLoading();
      }
    }
  }

  void _loadAccountByBook(book) {
    form['account'] = (){
      if (type == 'EXPENSE') {
        return book['defaultExpenseAccount'];
      }
      if (type == 'INCOME') {
        return book['defaultIncomeAccount'];
      }
      if (type == 'TRANSFER') {
        return book['defaultTransferFromAccount'];
      }
    }();
    if (type == 'TRANSFER') {
      form['to'] = book['defaultTransferToAccount'];
    }
  }

  void _loadCategoryByBook(book) {
    if (type == 'EXPENSE') {
      if (book['defaultExpenseCategory'] != null) {
        changeCategory([book['defaultExpenseCategory']]);
      } else {
        categories = [];
        form['categories'] = [];
      }
    } else if (type == 'INCOME') {
      if (book['defaultIncomeCategory'] != null) {
        changeCategory([book['defaultIncomeCategory']]);
      } else {
        categories = [];
        form['categories'] = [];
      }
    }
  }
  bool _checkValid() {
    if (type != 'TRANSFER') {
      if (categories.isEmpty) {
        return false;
      }
      for (var categoryAmount in form['categories']) {
        if (!validAmount(categoryAmount['amount'].toString())) {
          return false;
        }
        if (needConvert) {
          if (!validAmount(categoryAmount['convertedAmount'].toString())) {
            return false;
          }
        }
      }
    } else {
      if (form['account'] == null) {
        return false;
      }
      if (form['to'] == null) {
        return false;
      }
      if (!validAmount(form['amount'].toString())) {
        return false;
      }
      if (needConvert) {
        if (!validAmount(form['convertedAmount'].toString())) {
          return false;
        }
      }
    }
    return true;
  }

  void changeBook(value) {
    form['book'] = value;
    _loadAccountByBook(value);
    _loadCategoryByBook(value);
    form['payee'] = null;
    form['tags'] = null;
    valid = _checkValid();
    update();
  }

  void tabClick(int index) {
    if (index == 0) {
      type = 'EXPENSE';
    } else if (index == 1) {
      type = 'INCOME';
    } else if (index == 2) {
      type = 'TRANSFER';
    } else {
      throw Exception('index error');
    }
    _loadAccountByBook(form['book']);
    _loadCategoryByBook(form['book']);
    form['payee'] = null;
    form['tags'] = null;
    valid = _checkValid();
    update();
  }

  void changeCategory(values) {
    categories = values;
    form['categories'] = List<Map<String, dynamic>>.from(values.map((e) {
      // 先要查找之前有没有，避免每次更新分类都将之前的金额清空了。
      return form['categories'].firstWhere((e1) => e1['categoryId'] == e['id'], orElse: () {
        return {
          'category': e['id'],
          'categoryName': e['name'],
          'amount': '',
          'convertedAmount': '',
        };
      });
    }));
    update();
  }

  void checkValid() {
    valid = _checkValid();
    update();
  }

  bool get needConvert {
    if (form['account'] == null) {
      return false;
    }
    if (type == 'EXPENSE' || type == 'INCOME') {
      return form['account']['currencyCode'] != form['book']['defaultCurrencyCode'];
    } else if (type == 'TRANSFER') {
      if (form['to'] == null) {
        return false;
      }
      return form['account']['currencyCode'] != form['to']['currencyCode'];
    }
    return false;
  }

  String get convertCode {
    if (type == 'TRANSFER') {
      return form['to']['currencyCode'];
    } else {
      return form['book']['defaultCurrencyCode'];
    }
  }

  Map<String, dynamic> buildForm() {
    Map<String, dynamic> newForm = jsonDecode(jsonEncode(form));
    newForm['type'] = type;
    if (form['book']?['value'] != null) {
      newForm['book'] = form['book']?['value'];
    }
    if (form['account']?['value'] != null) {
      newForm['account'] = form['account']?['value'];
    }
    if (form['to']?['value'] != null) {
      newForm['to'] = form['to']?['value'];
    }
    if (form['payee']?['value'] != null) {
      newForm['payee'] = form['payee']?['value'];
    }
    if (!(form['tags']?.isEmpty ?? true)) {
      newForm['tags'] = form['tags'].map((e) => e['value']).toList();
    }
    if (type == 'TRANSFER') {
      newForm.remove('categories');
    }
    return newForm;
  }

  Future<double?> calcCurrency(double amount) async {
    try {
      Message.showLoading();
      return (await Http.get('currencies/calc', params: {
        'from': form['account']['currencyCode'],
        'to': convertCode,
        'amount': amount,
      }))['data'];
    } catch (_) {
      _.printError();
    } finally {
      Message.disLoading();
    }
    return null;
  }

}