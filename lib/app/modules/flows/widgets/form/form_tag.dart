import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/select/tree_select_option.dart';
import '../../controllers/flow_form_controller.dart';
import '../../../common/select/select_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';

class FormTag extends StatelessWidget {

  final FlowFormController controller;

  const FormTag({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MySelect(
      multiple: true,
      label: LocaleKeys.flow_tag.tr,
      value: controller.form['tags'],
      onFocus: () {
        Map<String, dynamic> query = { };
        query['bookId'] = controller.form['book']['value'];
        if (controller.type == 'EXPENSE') {
          query['canExpense'] = true;
        }
        if (controller.type == 'INCOME') {
          query['canIncome'] = true;
        }
        if (controller.type == 'TRANSFER') {
          query['canTransfer'] = true;
        }
        Get.find<SelectController>().load('tags', params: query);
        Get.to(() => TreeSelectOption(
          title: LocaleKeys.flow_tag.tr,
          values: controller.form['tags'],
          onSelect: (values) {
            controller.form['tags'] = values;
            controller.update();
            Get.back();
          },
        ));
      },
    );
  }

}