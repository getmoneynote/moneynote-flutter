import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/bottomsheet_container.dart';
import '/app/core/components/form/my_form_switch.dart';
import '/app/core/components/form/my_select.dart';
import '/app/core/utils/utils.dart';
import '/app/core/commons/form/not_empty_num_formz.dart';
import '/app/core/components/form/my_form_text.dart';
import '/generated/locales.g.dart';
import '/app/core/components/my_form_page.dart';
import '../../common/select/select_controller.dart';
import '../../common/select/select_option.dart';
import '../controllers/account_form_controller.dart';

class AccountFormPage extends StatelessWidget {

  const AccountFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountFormController>(builder: (controller) {
      return MyFormPage(
        title: Text(LocaleKeys.common_formTitle.trParams({
          'action': translateAction(controller.action),
          'name': LocaleKeys.menu_account.tr
        })),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: controller.valid ? () {
              Get.find<AccountFormController>().submit();
            } : null,
          )
        ],
        children: [
          MySelect(
            readOnly: controller.action == 2,
            label: LocaleKeys.account_detailLabelTypeName.tr,
            required: true,
            value: {
              'value': controller.type,
              'label': accountTypeToName(controller.type)
            },
            onFocus: () {
              Get.bottomSheet(
                BottomSheetContainer(
                  child: Wrap(
                    children: [
                      ListTile(
                        title: Text(LocaleKeys.account_checking.tr),
                        onTap: () => Get.find<AccountFormController>().changeType('CHECKING'),
                        selected: controller.type == 'CHECKING',
                      ),
                      ListTile(
                        title: Text(LocaleKeys.account_credit.tr),
                        onTap: () => Get.find<AccountFormController>().changeType('CREDIT'),
                        selected: controller.type == 'CREDIT',
                      ),
                      ListTile(
                        title: Text(LocaleKeys.account_asset.tr),
                        onTap: () => Get.find<AccountFormController>().changeType('ASSET'),
                        selected: controller.type == 'ASSET',
                      ),
                      ListTile(
                        title: Text(LocaleKeys.account_debt.tr),
                        onTap: () => Get.find<AccountFormController>().changeType('DEBT'),
                        selected: controller.type == 'DEBT',
                      ),
                    ]
                  )
                )
              );
            }
          ),
          MySelect(
            readOnly: controller.action == 2,
            label: LocaleKeys.account_detailLabelCurrency.tr,
            required: true,
            value: {
              'value': controller.form['currencyCode'],
              'label': controller.form['currencyCode']
            },
            onFocus: () {
              Get.find<SelectController>().load('currencies');
              Get.to(() => SelectOption(
                title: LocaleKeys.account_detailLabelCurrency.tr,
                value: {
                  'value': controller.form['currencyCode'],
                  'label': controller.form['currencyCode']
                },
                onSelect: (value) {
                  Get.find<AccountFormController>().changeCurrency(value['value']);
                },
              ));
            },
          ),
          MyFormText(
            required: true,
            label: LocaleKeys.account_detailLabelName.tr,
            value: controller.form['name'],
            onChange: (value) {
              Get.find<AccountFormController>().changeName(value);
            },
            errorText: (controller.nameFormz.isPure || controller.nameFormz.isValid) ? null : LocaleKeys.error_empty.tr ,
          ),
          MyFormText(
            readOnly: controller.action == 2,
            required: true,
            label: LocaleKeys.flow_currentBalance.tr,
            value: controller.form['balance'],
            onChange: (value) {
              Get.find<AccountFormController>().changeBalance(value);
            },
            errorText: (controller.balanceFormz.isPure || controller.balanceFormz.isValid)? null : controller.balanceFormz.displayError == NotEmptyNumError.empty ? LocaleKeys.error_empty.tr : LocaleKeys.error_format.tr,
          ),
          if (controller.type == 'CREDIT' || controller.type == 'DEBT') ...[
            MyFormText(
              label: LocaleKeys.account_detailLabelCreditLimit.tr,
              value: controller.form['creditLimit'],
              onChange: (value) {
                controller.form['creditLimit'] = value;
                controller.update();
              },
            ),
            MyFormText(
              label: controller.type == 'CREDIT' ? LocaleKeys.account_detailLabelBillDay.tr : LocaleKeys.account_detailLabelPayDay.tr,
              value: controller.form['billDay'],
              onChange: (value) {
                controller.form['billDay'] = value;
                controller.update();
              },
            ),
          ],
          if (controller.type == 'DEBT') ...[
            MyFormText(
              label: LocaleKeys.account_detailLabelApr.tr,
              value: controller.form['apr'],
              onChange: (value) {
                controller.form['apr'] = value;
                controller.update();
              },
            ),
          ],
          MyFormSwitch(
            label: LocaleKeys.account_detailLabelCanExpense.tr,
            value: controller.form['canExpense'],
            onChange: (value) {
              controller.form['canExpense'] = value;
              controller.update();
            },
          ),
          MyFormSwitch(
            label: LocaleKeys.account_detailLabelCanIncome.tr,
            value: controller.form['canIncome'],
            onChange: (value) {
              controller.form['canIncome'] = value;
              controller.update();
            },
          ),
          MyFormSwitch(
            label: LocaleKeys.account_detailLabelCanTransferTo.tr,
            value: controller.form['canTransferTo'],
            onChange: (value) {
              controller.form['canTransferTo'] = value;
              controller.update();
            },
          ),
          MyFormSwitch(
            label: LocaleKeys.account_detailLabelCanTransferFrom.tr,
            value: controller.form['canTransferFrom'],
            onChange: (value) {
              controller.form['canTransferFrom'] = value;
              controller.update();
            },
          ),
          MyFormSwitch(
            label: LocaleKeys.account_detailLabelInclude.tr,
            value: controller.form['include'],
            onChange: (value) {
              controller.form['include'] = value;
              controller.update();
            },
          ),
          MyFormText(
            label: LocaleKeys.account_detailLabelNo.tr,
            value: controller.form['no'],
            onChange: (value) {
              controller.form['no'] = value;
              controller.update();
            },
          ),
          MyFormText(
            label: LocaleKeys.common_notes.tr,
            value: controller.form['notes'],
            onChange: (value) {
              controller.form['notes'] = value;
              controller.update();
            },
          ),
          const SizedBox(height: 70),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.send),
              onPressed: controller.valid ? () {
                Get.find<AccountFormController>().submit();
              } : null,
              label: Text(LocaleKeys.common_submit.tr)
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                Get.find<AccountFormController>().reset();
              },
              label: Text(LocaleKeys.common_reset.tr)
            ),
          )
        ]
      );
    });
  }

}