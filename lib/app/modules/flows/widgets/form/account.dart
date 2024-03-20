import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/flow_form_controller.dart';
import '/app/modules/common/select/select_option.dart';
import '../../../common/select/select_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';

class Account extends StatelessWidget {

  final FlowFormController controller;

  const Account({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MySelect(
      readOnly: controller.action == 2,
      required: controller.type == 'TRANSFER',
      label: controller.type == 'TRANSFER'? LocaleKeys.flow_from.tr : LocaleKeys.flow_account.tr,
      value: controller.form['account'],
      onFocus: () {
        Map<String, dynamic> query = { };
        if (controller.type == 'EXPENSE') {
          query['canExpense'] = true;
        }
        if (controller.type == 'INCOME') {
          query['canIncome'] = true;
        }
        if (controller.type == 'TRANSFER') {
          query['canTransferFrom'] = true;
        }
        Get.find<SelectController>().load('accounts', params: query);
        Get.to(() => SelectOption(
          title: LocaleKeys.menu_account.tr,
          value: controller.form['account'],
          onSelect: (value) {
            controller.form['account'] = value;
            controller.checkValid();
            Get.back();
          },
        ));
      },
    );
  }

}