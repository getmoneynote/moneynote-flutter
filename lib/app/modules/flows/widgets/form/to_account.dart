import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/flow_form_controller.dart';
import '/app/modules/common/select/select_option.dart';
import '../../../common/select/select_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';

class ToAccount extends StatelessWidget {

  final FlowFormController controller;

  const ToAccount({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MySelect(
      required: true,
      label: LocaleKeys.flow_to.tr,
      value: controller.form['to'],
      onFocus: () {
        Get.find<SelectController>().load('accounts', params: { 'canTransferTo': true });
        Get.to(() => SelectOption(
          title: LocaleKeys.menu_account.tr,
          value: controller.form['to'],
          onSelect: (value) {
            controller.form['to'] = value;
            controller.checkValid();
            Get.back();
          },
        ));
      },
    );
  }

}