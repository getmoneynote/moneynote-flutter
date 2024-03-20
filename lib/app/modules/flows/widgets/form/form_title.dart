import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/flow_form_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_form_text.dart';

class FormTitle extends StatelessWidget {

  final FlowFormController controller;

  const FormTitle({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MyFormText(
      label: LocaleKeys.flow_title.tr,
      value: controller.form['title'],
      onChange: (value) {
        controller.form['title'] = value;
        controller.update();
      },
    );
  }

}