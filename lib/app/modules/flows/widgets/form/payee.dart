import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/flow_form_controller.dart';
import '/app/modules/common/select/select_option.dart';
import '../../../common/select/select_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';

class Payee extends StatelessWidget {

  final FlowFormController controller;

  const Payee({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MySelect(
      label: LocaleKeys.flow_payee.tr,
      value: controller.form['payee'],
      onFocus: () {
        Map<String, dynamic> query = { };
        query['bookId'] = controller.form['book']['value'];
        if (controller.form['type'] == 'EXPENSE') {
          query['canExpense'] = true;
        }
        if (controller.form['type'] == 'INCOME') {
          query['canIncome'] = true;
        }
        Get.find<SelectController>().load('payees', params: query);
        Get.to(() => SelectOption(
          title: LocaleKeys.menu_account.tr,
          value: controller.form['payee'],
          onSelect: (value) {
            controller.form['payee'] = value;
            controller.update();
            Get.back();
          },
        ));
      },
    );
  }

}