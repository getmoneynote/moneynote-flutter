import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/flow_form_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_form_text.dart';

class TransferAmount extends StatelessWidget {

  final FlowFormController controller;

  const TransferAmount({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyFormText(
          readOnly: controller.action == 2,
          required: true,
          label: LocaleKeys.flow_amount.tr,
          value: controller.form['amount'],
          onChange: (value) {
            controller.form['amount'] = value;
            controller.checkValid();
          },
        ),
        if (controller.needConvert) ...[
          MyFormText(
            readOnly: controller.action == 2,
            required: true,
            label: LocaleKeys.account_detailLabelConvert.trParams({'code': controller.convertCode}),
            value: controller.form['convertedAmount'],
            onChange: (value) {
              controller.form['convertedAmount'] = value;
              controller.checkValid();
            },
          )
        ]
      ],
    );
  }

}