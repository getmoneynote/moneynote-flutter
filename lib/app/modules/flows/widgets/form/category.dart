import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/select/tree_select_option.dart';
import '../../controllers/flow_form_controller.dart';
import '../../../common/select/select_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';

class Category extends StatelessWidget {

  final FlowFormController controller;

  const Category({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MySelect(
      readOnly: controller.action == 2,
      required: true,
      multiple: true,
      label: LocaleKeys.flow_category.tr,
      value: controller.categories,
      onFocus: () {
        Map<String, dynamic> query = { };
        query['bookId'] = controller.form['book']['value'];
        query['type'] = controller.type;
        Get.find<SelectController>().load('categories', params: query);
        Get.to(() => TreeSelectOption(
          title: LocaleKeys.flow_category.tr,
          values: controller.categories,
          onSelect: (values) {
            Get.find<FlowFormController>().changeCategory(values);
            Get.back();
          },
        ));
      },
    );
  }

}