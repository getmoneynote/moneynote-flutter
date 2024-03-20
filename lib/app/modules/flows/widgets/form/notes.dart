import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/flow_form_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_form_text.dart';

class Notes extends StatelessWidget {

  final FlowFormController controller;

  const Notes({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MyFormText(
      label: LocaleKeys.common_notes.tr,
      value: controller.form['notes'],
      onChange: (value) {
        controller.form['notes'] = value;
        controller.update();
      },
    );
  }

}