import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/form/my_tree_option.dart';
import '/app/modules/common/select/select_controller.dart';

class TreeSelectOption extends StatelessWidget {

  final String title;
  final List<dynamic>? values;
  final Function onSelect;

  const TreeSelectOption({
    super.key,
    required this.title,
    required this.onSelect,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectController>(builder: (controller) {
      return MyTreeOption(
        pageTitle: title,
        status: controller.status,
        options: controller.options,
        values: values,
        onSelect: onSelect,
      );
    });
  }

}