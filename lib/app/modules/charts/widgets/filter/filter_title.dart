import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../charts_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_form_text.dart';

class FilterTitle extends StatelessWidget {

  const FilterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartsController>(builder: (controller) {
      return MyFormText(
        label: LocaleKeys.flow_title.tr,
        value: controller.query['title'],
        onChange: (value) {
          controller.query['title'] = value;
          controller.update();
        },
      );
    });
  }

}