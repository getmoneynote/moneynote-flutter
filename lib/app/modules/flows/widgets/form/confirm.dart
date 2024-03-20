import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/form/my_form_switch.dart';
import '../../controllers/flow_form_controller.dart';
import '/generated/locales.g.dart';

class Confirm extends StatelessWidget {

  final FlowFormController controller;

  const Confirm({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MyFormSwitch(
      readOnly: controller.action == 2,
      required: true,
      label: LocaleKeys.flow_confirm.tr,
      value: controller.form['confirm'],
      onChange: (value) {
        controller.form['confirm'] = value;
        controller.update();
      },
    );
  }

}