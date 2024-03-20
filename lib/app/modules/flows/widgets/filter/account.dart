import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';
import '../../../common/select/select_controller.dart';
import '../../../common/select/select_option.dart';
import '../../controllers/flows_controller.dart';

class Account extends StatelessWidget {

  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MySelect(
        label: LocaleKeys.menu_account.tr,
        value: controller.query['account'],
        allowClear: true,
        onClear: () {
          controller.query['account'] = null;
          controller.update();
        },
        onFocus: () {
          Get.find<SelectController>().load('accounts');
          Get.to(() => SelectOption(
            title: LocaleKeys.menu_account.tr,
            value: controller.query['account'],
            onSelect: (value) {
              controller.query['account'] = value;
              controller.update();
              Get.back();
            },
          ));
        },
      );
    });
  }

}