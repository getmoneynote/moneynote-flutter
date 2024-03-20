import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/form/my_form_date.dart';
import '../../controllers/flow_form_controller.dart';
import '/generated/locales.g.dart';

class CreateTime extends StatelessWidget {

  final FlowFormController controller;

  const CreateTime({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return MyFormDate(
      required: true,
      label: LocaleKeys.flow_createTime.tr,
      value: controller.form['createTime'],
      onChange: (value) {
        controller.form['createTime'] = value;
        controller.update();
      },
    );
  }

}