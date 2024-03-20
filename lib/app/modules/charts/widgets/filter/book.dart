import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/charts/charts_controller.dart';
import '/app/modules/common/select/select_option.dart';
import '../../../common/select/select_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';

class Book extends StatelessWidget {

  const Book({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(builder: (controller) {
      return MySelect(
        label: LocaleKeys.book_whichBook.tr,
        value: controller.query['book'],
        onFocus: () {
          Get.find<SelectController>().load('books');
          Get.to(() => SelectOption(
            title: LocaleKeys.book_whichBook.tr,
            value: controller.query['book'],
            onSelect: (value) {
              controller.query['book'] = value;
              controller.update();
              Get.back();
            },
          ));
        },
      );
    });
  }

}