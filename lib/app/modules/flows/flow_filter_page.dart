import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/flows/widgets/filter/index.dart';
import '/app/modules/flows/controllers/flows_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/my_form_page.dart';

class FlowFilterPage extends StatelessWidget {

  const FlowFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFormPage(
        title: Text(LocaleKeys.flow_filterPageTitle.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              Get.find<FlowsController>().reload();
              Get.back();
            },
          )
        ],
        children: [
          const Book(),
          const Type(),
          const FilterTitle(),
          const Account(),
          const Payee(),
          const Category(),
          const FilterTag(),
          const MinTime(),
          const MaxTime(),
          const MinAmount(),
          const MaxAmount(),
          const Confirm(),
          const Include(),
          const HasFile(),
          const Notes(),
          const SizedBox(height: 70),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
                icon: const Icon(Icons.done),
                onPressed: () {
                  Get.find<FlowsController>().reload();
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
                  Get.find<FlowsController>().reset();
                },
                label: Text(LocaleKeys.common_reset.tr)
            ),
          )
        ]
    );
  }

}