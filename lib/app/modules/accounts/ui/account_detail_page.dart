import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/account_form_controller.dart';
import '/app/modules/accounts/controllers/account_adjust_controller.dart';
import '/app/core/components/dialog_confirm.dart';
import '/app/core/components/detail_item.dart';
import '/app/modules/accounts/controllers/account_detail_controller.dart';
import '/app/modules/login/controllers/auth_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/base/enums.dart';
import '/app/core/components/pages/index.dart';
import '/app/core/utils/message.dart';
import '/app/core/utils/utils.dart';
import 'account_adjust_page.dart';
import 'account_form_page.dart';

class AccountDetailPage extends StatelessWidget {

  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.account_detailTitle.tr),
      ),
      body: GetBuilder<AccountDetailController>(builder: (controller) {
        LoadDataStatus status = controller.status;
        switch (status) {
          case LoadDataStatus.progress:
          case LoadDataStatus.initial:
            return const LoadingPage();
          case LoadDataStatus.success:
            return ContentPage(
              child: Column(
                children: [
                  DetailItem(
                    label: LocaleKeys.account_detailLabelTypeName.tr,
                    value: controller.item['typeName']
                  ),
                  DetailItem(
                    label: LocaleKeys.account_detailLabelName.tr,
                    value: controller.item['name'], space: false
                  ),
                  DetailItem(
                    label: LocaleKeys.account_detailLabelBalance.tr,
                    value: controller.item['balance'].toStringAsFixed(2),
                    tail: TextButton(
                      child: Text(LocaleKeys.account_detailAdjust.tr),
                      onPressed: () {
                        Get.put(AccountAdjustController(1, controller.item));
                        Get.to(() => const AccountAdjustPage(), fullscreenDialog: true)?.then(
                          (value) => Get.delete<AccountAdjustController>()
                        );
                      }
                    ),
                    space: false,
                  ),
                  DetailItem(
                    label: LocaleKeys.account_detailLabelCurrency.tr,
                    value: controller.item['currencyCode']
                  ),
                  if (controller.item['currencyCode'] != authController.groupCurrency()) ...[
                    DetailItem(
                      label: LocaleKeys.account_detailLabelCurrencyRate.tr,
                      value: controller.item['rate'].toString()
                    ),
                    DetailItem(
                      label: LocaleKeys.account_detailLabelConvert.trParams({'code': authController.groupCurrency()}),
                      value: controller.item['convertedBalance'].toStringAsFixed(2)
                    ),
                  ],
                  if (controller.item['type'] == 'CREDIT' || controller.item['type'] == 'DEBT') ...[
                    DetailItem(
                      label: LocaleKeys.account_detailLabelCreditLimit.tr,
                      value: controller.item['creditLimit']?.toStringAsFixed(2)
                    ),
                    DetailItem(
                      label: LocaleKeys.account_detailLabelRemainLimit.tr,
                      value: controller.item['remainLimit']?.toStringAsFixed(2)
                    ),
                  ],
                  if (controller.item['type'] == 'CREDIT') ...[
                    DetailItem(
                      label: LocaleKeys.account_detailLabelBillDay.tr,
                      value: controller.item['billDay']?.toString()
                    )
                  ],
                  if (controller.item['type'] == 'DEBT') ...[
                    DetailItem(
                      label: LocaleKeys.account_detailLabelPayDay.tr,
                      value: controller.item['billDay']?.toString()
                    ),
                    DetailItem(
                      label: LocaleKeys.account_detailLabelApr.tr,
                      value: controller.item['apr']?.toString()
                    )
                  ],
                  DetailItem(
                    label: LocaleKeys.account_detailLabelInclude.tr,
                    value: boolToString(controller.item['include'])
                  ),
                  DetailItem(
                    label: LocaleKeys.account_detailLabelCanExpense.tr,
                    value: boolToString(controller.item['canExpense'])
                  ),
                  DetailItem(
                    label: LocaleKeys.account_detailLabelCanIncome.tr,
                    value: boolToString(controller.item['canIncome'])
                  ),
                  DetailItem(
                    label: LocaleKeys.account_detailLabelCanTransferTo.tr,
                    value: boolToString(controller.item['canTransferTo'])
                  ),
                  DetailItem(
                    label: LocaleKeys.account_detailLabelCanTransferFrom.tr,
                    value: boolToString(controller.item['canTransferFrom']),
                    space: !(controller.item['no'] != null && controller.item['no'].toString().isNotEmpty)
                  ),
                  (controller.item['no'] != null && controller.item['no'].toString().isNotEmpty) ?
                  DetailItem(
                    label: LocaleKeys.account_detailLabelNo.tr,
                    value: controller.item['no'],
                    tail: TextButton(
                      child: Text(LocaleKeys.common_copy.tr),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: controller.item['no'])).then((_) => Message.success(LocaleKeys.common_operationSuccess.tr));
                      }
                    ),
                    space: false
                  ) :
                  DetailItem(
                    label: LocaleKeys.account_detailLabelNo.tr,
                    value: controller.item['no']
                  ),
                  DetailItem(
                    label: LocaleKeys.common_notes.tr,
                    value: controller.item['notes'], crossAlign: CrossAxisAlignment.start
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.edit, size: 15),
                      onPressed: () {
                        Get.put(AccountFormController(controller.item['type'], 2, controller.item));
                        Get.to(() => const AccountFormPage(), fullscreenDialog: true)?.then(
                          (value) => Get.delete<AccountFormController>()
                        );
                      },
                      label: Text(LocaleKeys.common_edit.tr),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: DialogConfirm(
                        child: AbsorbPointer(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.delete, size: 15),
                            onPressed: controller.deleteStatus == LoadDataStatus.progress ? null : () { },
                            label: Text(LocaleKeys.common_delete.tr),
                          ),
                        ),
                        onConfirm: () {
                          Get.find<AccountDetailController>().delete();
                        }
                    ),
                  )
                ],
              )
            );
          default:
            return const ErrorPage();
        }
      }),
    );
  }

}