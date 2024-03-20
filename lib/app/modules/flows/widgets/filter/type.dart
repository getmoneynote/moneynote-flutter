import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/bottomsheet_container.dart';
import '/app/core/utils/utils.dart';
import '/generated/locales.g.dart';
import '/app/core/components/form/my_select.dart';
import '../../controllers/flows_controller.dart';

class Type extends StatelessWidget {

  const Type({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowsController>(builder: (controller) {
      return MySelect(
        label: LocaleKeys.flow_type.tr,
        value: controller.query['type'] != null ? {
          'value': controller.query['type'],
          'label': flowTypeToName(controller.query['type'])
        } : null,
        onFocus: () {
          Get.bottomSheet(
            BottomSheetContainer(
              child: Wrap(
                children: [
                  ListTile(
                    title: Text(LocaleKeys.flow_type1.tr),
                    onTap: () {
                      controller.query['type'] = 'EXPENSE';
                      controller.update();
                      if(Get.isBottomSheetOpen ?? false){
                        Get.back();
                      }
                    },
                    selected: controller.query['type'] == 'EXPENSE',
                  ),
                  ListTile(
                    title: Text(LocaleKeys.flow_type2.tr),
                    onTap: () {
                      controller.query['type'] = 'INCOME';
                      controller.update();
                      if(Get.isBottomSheetOpen ?? false){
                        Get.back();
                      }
                    },
                    selected: controller.query['type'] == 'INCOME',
                  ),
                  ListTile(
                    title: Text(LocaleKeys.flow_type3.tr),
                    onTap: () {
                      controller.query['type'] = 'TRANSFER';
                      controller.update();
                      if(Get.isBottomSheetOpen ?? false){
                        Get.back();
                      }
                    },
                    selected: controller.query['type'] == 'TRANSFER',
                  ),
                  ListTile(
                    title: Text(LocaleKeys.flow_type4.tr),
                    onTap: () {
                      controller.query['type'] = 'ADJUST';
                      controller.update();
                      if(Get.isBottomSheetOpen ?? false){
                        Get.back();
                      }
                    },
                    selected: controller.query['type'] == 'ADJUST',
                  ),
                ]
              )
            )
          );
        },
        allowClear: true,
        onClear: () {
          controller.query['type'] = null;
          controller.update();
        },
      );
    });
  }

}