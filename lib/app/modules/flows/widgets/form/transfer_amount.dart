import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/utils.dart';
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
          required: true,
          label: LocaleKeys.flow_amount.tr,
          value: controller.form['amount'],
          onChange: (value) {
            controller.form['amount'] = value;
            controller.checkValid();
          },
        ),
        if (controller.needConvert) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: MyFormText(
                  required: true,
                  label: LocaleKeys.account_detailLabelConvert.trParams({'code': controller.convertCode}),
                  value: controller.form['convertedAmount'],
                  onChange: (value) {
                    controller.form['convertedAmount'] = value;
                    controller.checkValid();
                  },
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (validAmount(controller.form['amount'])) {
                    double? c = await Get.find<FlowFormController>().calcCurrency(double.parse(controller.form['amount'].toString()));
                    if (c != null) {
                      controller.form['convertedAmount'] = c;
                      controller.checkValid();
                    }
                  }
                },
                icon: const Icon(Icons.calculate)
              )
            ],
          )
        ]
      ],
    );
  }

}