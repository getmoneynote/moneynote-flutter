import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/form/my_select.dart';
import '/app/core/utils/utils.dart';
import '/app/core/components/bottomsheet_container.dart';
import '/generated/locales.g.dart';
import '../../controllers/flows_controller.dart';

class HasFile extends StatelessWidget {

  const HasFile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MySelect(
        label: LocaleKeys.flow_hasFile.tr,
        value: controller.query['hasFile'] != null ? {
          'value': controller.query['hasFile'],
          'label': hasToString(controller.query['hasFile'])
        } : null,
        onFocus: () {
          Get.bottomSheet(
            BottomSheetContainer(
              child: Wrap(
                children: [
                  ListTile(
                    title: Text(LocaleKeys.common_has.tr),
                    onTap: () {
                      controller.query['hasFile'] = true;
                      controller.update();
                      if(Get.isBottomSheetOpen ?? false){
                        Get.back();
                      }
                    },
                    selected: controller.query['hasFile'] == true,
                  ),
                  ListTile(
                    title: Text(LocaleKeys.common_none.tr),
                    onTap: () {
                      controller.query['hasFile'] = false;
                      controller.update();
                      if(Get.isBottomSheetOpen ?? false){
                        Get.back();
                      }
                    },
                    selected: controller.query['hasFile'] == false,
                  ),
                ]
              )
            )
          );
        },
        allowClear: true,
        onClear: () {
          controller.query['hasFile'] = null;
          controller.update();
        },
      );
    });
  }

}