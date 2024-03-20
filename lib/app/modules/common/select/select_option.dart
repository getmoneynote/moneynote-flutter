import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/common/select/select_controller.dart';
import '/app/core/components/form/my_option.dart';

class SelectOption extends StatelessWidget {

  final dynamic value;
  final Function onSelect;
  final String title;

  const SelectOption({
    super.key,
    this.value = const { },
    required this.onSelect,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectController>(builder: (controller) {
      return MyOption(
        status: controller.status,
        options: controller.options,
        value: value,
        onSelect: onSelect,
        pageTitle: title,
      );
    });
  }

}