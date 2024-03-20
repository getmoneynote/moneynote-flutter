import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/utils.dart';
import '../../common/select/select_controller.dart';
import '../../common/select/select_option.dart';
import '/app/core/components/form/my_form_date.dart';
import '/app/core/components/form/my_form_text.dart';
import '/app/core/components/form/my_select.dart';
import '/app/modules/accounts/controllers/account_adjust_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/commons/form/not_empty_num_formz.dart';
import '/app/core/components/my_form_page.dart';


class AccountAdjustPage extends StatelessWidget {

  const AccountAdjustPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountAdjustController>(builder: (controller) {
      return MyFormPage(
        title: Text(LocaleKeys.common_formTitle.trParams({
          'action': translateAction(controller.action),
          'name': LocaleKeys.account_adjustPageTitle.tr
        })),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: controller.valid ? () {
              Get.find<AccountAdjustController>().submit();
            } : null,
          ),
        ],
        children: [
          MySelect(
            label: LocaleKeys.book_whichBook.tr,
            required: true,
            value: controller.form['book'],
            onFocus: () {
              Get.find<SelectController>().load('books');
              Get.to(() => SelectOption(
                title: LocaleKeys.book_whichBook.tr,
                value: controller.form['book'],
                onSelect: (value) {
                  controller.form['book'] = value;
                  controller.update();
                  Get.back();
                },
              ));
            },
          ),
          MyFormText(
            label: LocaleKeys.flow_title.tr,
            value: controller.form['title'],
            onChange: (value) {
              controller.form['title'] = value;
              controller.update();
            },
          ),
          MyFormDate(
            label: LocaleKeys.flow_createTime.tr,
            value: controller.form['createTime'],
            required: true,
            onChange: (value) {
              controller.form['createTime'] = value;
              controller.update();
            },
          ),
          if (controller.action == 1) ...[
            MyFormText(
              required: true,
              label: LocaleKeys.flow_currentBalance.tr,
              value: controller.form['balance'],
              onChange: (value) {
                Get.find<AccountAdjustController>().balanceChanged(value);
              },
              errorText: (controller.balanceFormz.isPure || controller.balanceFormz.isValid)? null : controller.balanceFormz.displayError == NotEmptyNumError.empty ? LocaleKeys.error_empty.tr : LocaleKeys.error_format.tr,
            ),
          ],
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
                  Get.find<AccountAdjustController>().submit();
                } : null,
                label: Text(LocaleKeys.common_submit.tr)
            ),
          )
        ]
      );
    });
  }

}

