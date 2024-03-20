import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_form_text.dart';
import '../../controllers/flows_controller.dart';

class Notes extends StatelessWidget {

  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MyFormText(
        label: LocaleKeys.common_notes.tr,
        value: controller.query['notes'],
        onChange: (value) {
          controller.query['notes'] = value;
          controller.update();
        },
      );
    });
  }

}