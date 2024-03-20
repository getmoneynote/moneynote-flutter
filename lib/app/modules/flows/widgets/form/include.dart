import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/form/my_form_switch.dart';
import '../../controllers/flow_form_controller.dart';
import '/generated/locales.g.dart';

class Include extends StatelessWidget {

  final FlowFormController controller;

  const Include({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MyFormSwitch(
      required: true,
      label: LocaleKeys.flow_include.tr,
      value: controller.form['include'],
      onChange: (value) {
        controller.form['include'] = value;
        controller.update();
      },
    );
  }

}