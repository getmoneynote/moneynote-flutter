import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/form/my_select.dart';
import '/app/core/utils/utils.dart';
import '/app/core/components/bottomsheet_container.dart';
import '/generated/locales.g.dart';
import '../../controllers/flows_controller.dart';

class Confirm extends StatelessWidget {

  const Confirm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MySelect(
        label: LocaleKeys.flow_confirm.tr,
        value: controller.query['confirm'] != null ? {
          'value': controller.query['confirm'],
          'label': boolToString(controller.query['confirm'])
        } : null,
        onFocus: () {
          Get.bottomSheet(
            BottomSheetContainer(
              child: Wrap(
                children: [
                  ListTile(
                    title: Text(LocaleKeys.common_yes.tr),
                    onTap: () {
                      controller.query['confirm'] = true;
                      controller.update();
                      if(Get.isBottomSheetOpen ?? false){
                        Get.back();
                      }
                    },
                    selected: controller.query['confirm'] == true,
                  ),
                  ListTile(
                    title: Text(LocaleKeys.common_no.tr),
                    onTap: () {
                      controller.query['confirm'] = false;
                      controller.update();
                      if(Get.isBottomSheetOpen ?? false){
                        Get.back();
                      }
                    },
                    selected: controller.query['confirm'] == false,
                  ),
                ]
              )
            )
          );
        },
        allowClear: true,
        onClear: () {
          controller.query['confirm'] = null;
          controller.update();
        },
      );
    });
  }

}