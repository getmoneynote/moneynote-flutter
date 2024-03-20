import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/form/my_select.dart';
import '/app/core/utils/utils.dart';
import '/app/core/components/bottomsheet_container.dart';
import '/generated/locales.g.dart';
import '../../controllers/flows_controller.dart';

class Include extends StatelessWidget {

  const Include({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MySelect(
        label: LocaleKeys.flow_include.tr,
        value: controller.query['include'] != null ? {
          'value': controller.query['include'],
          'label': boolToString(controller.query['include'])
        } : null,
        onFocus: () {
          Get.bottomSheet(
            BottomSheetContainer(
              child: Wrap(
                children: [
                  ListTile(
                    title: Text(LocaleKeys.common_yes.tr),
                    onTap: () {
                      controller.query['include'] = true;
                      controller.update();
                      if(Get.isBottomSheetOpen ?? false){
                        Get.back();
                      }
                    },
                    selected: controller.query['include'] == true,
                  ),
                  ListTile(
                    title: Text(LocaleKeys.common_no.tr),
                    onTap: () {
                      controller.query['include'] = false;
                      controller.update();
                      if(Get.isBottomSheetOpen ?? false){
                        Get.back();
                      }
                    },
                    selected: controller.query['include'] == false,
                  ),
                ]
              )
            )
          );
        },
        allowClear: true,
        onClear: () {
          controller.query['include'] = null;
          controller.update();
        },
      );
    });
  }

}