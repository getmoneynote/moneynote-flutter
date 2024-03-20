import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/charts/charts_controller.dart';
import './widgets/filter/index.dart';
import '/app/core/components/my_form_page.dart';
import '/generated/locales.g.dart';

class ChartFilterPage extends StatelessWidget {

  const ChartFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFormPage(
      title: Text(LocaleKeys.flow_filterPageTitle.tr),
      actions: [
        IconButton(
          icon: const Icon(Icons.done),
          onPressed: () {
            Get.find<ChartsController>().reload();
            Get.back();
          },
        )
      ],
      children: [
        const Book(),
        const FilterTitle(),
        const MinTime(),
        const MaxTime(),
        const Category(),
        const FilterTag(),
        const Payee(),
        const Account(),
        const SizedBox(height: 70),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.done),
            onPressed: () {
              Get.find<ChartsController>().reload();
              Get.back();
            },
            label: Text(LocaleKeys.common_submit.tr)
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Get.find<ChartsController>().reset();
            },
            label: Text(LocaleKeys.common_reset.tr)
          ),
        )
      ],
    );
  }



}