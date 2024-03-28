import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../charts_controller.dart';
import '../../../common/select/tree_select_option.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';
import '../../../common/select/select_controller.dart';

class Category extends StatelessWidget {

  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(builder: (controller) {
      return MySelect(
        multiple: true,
        label: LocaleKeys.flow_category.tr,
        value: controller.query['categories'],
        allowClear: true,
        onClear: () {
          controller.query['categories'] = null;
          controller.update();
        },
        onFocus: () {
          Map<String, dynamic> query = { };
          if (controller.query['book'] != null) {
            query['bookId'] = controller.query['book']['value'];
          }
          if (controller.tabIndex == 0) {
            query['type'] = 'EXPENSE';
          } else if (controller.tabIndex == 1) {
            query['type'] = 'INCOME';
          }
          Get.find<SelectController>().load('categories', params: query);
          Get.to(() => TreeSelectOption(
            title: LocaleKeys.flow_category.tr,
            values: controller.query['categories'],
            onSelect: (values) {
              controller.query['categories'] = values;
              controller.update();
              Get.back();
            },
          ), fullscreenDialog: true);
        },
      );
    });
  }

}