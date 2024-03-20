import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_form_text.dart';
import '../../controllers/flows_controller.dart';

class MinAmount extends StatelessWidget {

  const MinAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MyFormText(
        label: LocaleKeys.flow_minAmount.tr,
        value: controller.query['minAmount'],
        onChange: (value) {
          controller.query['minAmount'] = value;
          controller.update();
        },
      );
    });
  }

}