import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/form/my_form_date.dart';
import '/generated/locales.g.dart';
import '../../controllers/flows_controller.dart';

class MaxTime extends StatelessWidget {

  const MaxTime({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MyFormDate(
        label: LocaleKeys.common_maxTime.tr,
        value: controller.query['maxTime'],
        andTime: false,
        onChange: (value) {
          controller.query['maxTime'] = value;
          controller.update();
        },
        allowClear: true,
        onClear: () {
          controller.query['maxTime'] = null;
          controller.update();
        },
      );
    });
  }

}