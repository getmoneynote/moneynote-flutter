import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/form/my_form_date.dart';
import '/generated/locales.g.dart';
import '../../controllers/flows_controller.dart';

class MinTime extends StatelessWidget {

  const MinTime({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MyFormDate(
        label: LocaleKeys.common_minTime.tr,
        value: controller.query['minTime'],
        andTime: false,
        onChange: (value) {
          controller.query['minTime'] = value;
          controller.update();
        },
        allowClear: true,
        onClear: () {
          controller.query['minTime'] = null;
          controller.update();
        },
      );
    });
  }

}