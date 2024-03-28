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
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.schedule),
            onPressed: () {
              Get.find<ChartsController>().setTime1();
            },
            label: Text(LocaleKeys.chart_searchTime1.tr)
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
              icon: const Icon(Icons.schedule),
              onPressed: () {
                Get.find<ChartsController>().setTime2();
              },
              label: Text(LocaleKeys.chart_searchTime2.tr)
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
              icon: const Icon(Icons.schedule),
              onPressed: () {
                Get.find<ChartsController>().setTime3();
              },
              label: Text(LocaleKeys.chart_searchTime3.tr)
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
              icon: const Icon(Icons.schedule),
              onPressed: () {
                Get.find<ChartsController>().setTime4();
              },
              label: Text(LocaleKeys.chart_searchTime4.tr)
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
              icon: const Icon(Icons.schedule),
              onPressed: () {
                Get.find<ChartsController>().setTime5();
              },
              label: Text(LocaleKeys.chart_searchTime5.tr)
          ),
        ),
      ],
    );
  }



}