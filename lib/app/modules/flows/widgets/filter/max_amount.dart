import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_form_text.dart';
import '../../controllers/flows_controller.dart';

class MaxAmount extends StatelessWidget {

  const MaxAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MyFormText(
        label: LocaleKeys.flow_maxAmount.tr,
        value: controller.query['maxAmount'],
        onChange: (value) {
          controller.query['maxAmount'] = value;
          controller.update();
        },
      );
    });
  }

}