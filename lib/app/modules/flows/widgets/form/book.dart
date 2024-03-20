import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/flow_form_controller.dart';
import '/app/modules/common/select/select_option.dart';
import '../../../common/select/select_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';

class Book extends StatelessWidget {

  final FlowFormController controller;

  const Book({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MySelect(
      required: true,
      readOnly: controller.action != 1,
      label: LocaleKeys.book_whichBook.tr,
      value: controller.form['book'],
      onFocus: () {
        Get.find<SelectController>().load('books');
        Get.to(() => SelectOption(
          title: LocaleKeys.book_whichBook.tr,
          value: controller.form['book'],
          onSelect: (value) {
            Get.find<FlowFormController>().changeBook(value);
            Get.back();
          },
        ));
      },
    );
  }

}