import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moneynote/app/modules/flows/widgets/flow_file_list.dart';
import '/app/modules/flows/controllers/flow_form_controller.dart';
import '/app/modules/flows/flow_form_page.dart';
import '../accounts/controllers/account_adjust_controller.dart';
import '../accounts/ui/account_adjust_page.dart';
import '/app/core/utils/utils.dart';
import '../../core/components/detail_item.dart';
import '/app/core/components/dialog_confirm.dart';
import '/generated/locales.g.dart';
import '/app/core/base/enums.dart';
import '/app/core/components/pages/index.dart';
import 'controllers/flow_detail_controller.dart';

class FlowDetailPage extends StatelessWidget {

  const FlowDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.flow_detailTitle.tr),
      ),
      body: GetBuilder<FlowDetailController>(builder: (controller) {
        LoadDataStatus status = controller.status;
        Map<String, dynamic> item = controller.item;
        switch (status) {
          case LoadDataStatus.progress:
          case LoadDataStatus.initial:
            return const LoadingPage();
          case LoadDataStatus.success:
            if (item['book'] == null) {
              return const SizedBox.shrink();
            }
            return ContentPage(
              child: Column(
                children: [
                  DetailItem(
                    label: LocaleKeys.book_whichBook.tr,
                    value: item['book']['name']
                  ),
                  DetailItem(
                    label: LocaleKeys.flow_type.tr,
                    value: item['typeName']
                  ),
                  DetailItem(
                    label: LocaleKeys.flow_title.tr,
                    value: item['title']
                  ),
                  DetailItem(
                    label: LocaleKeys.flow_createTime.tr,
                    value: dateTimeFormat(item['createTime'])
                  ),
                  DetailItem(
                    label: LocaleKeys.flow_account.tr,
                    value: item['accountName']
                  ),
                  DetailItem(
                    label: LocaleKeys.flow_amount.tr,
                    value: item['amount'].toStringAsFixed(2)
                  ),
                  if (item['needConvert']) ...[
                    DetailItem(
                        label: LocaleKeys.account_detailLabelConvert.trParams({'code': item['convertCode']}),
                        value: item['convertedAmount'].toStringAsFixed(2)
                    ),
                  ],
                  if (item['categoryName']?.isNotEmpty ?? false) ...[
                    DetailItem(
                      label: LocaleKeys.flow_category.tr,
                      value: item['categoryName']
                    ),
                  ],
                  if (item['type'] != 'ADJUST') ...[
                    DetailItem(
                      label: LocaleKeys.flow_tag.tr,
                      value: item['tagsName']
                    ),
                    DetailItem(
                      label: LocaleKeys.flow_payee.tr,
                      value: item['payee']?['name']
                    ),
                    DetailItem(
                      label: LocaleKeys.flow_confirm.tr,
                      value: boolToString(item['confirm'])
                    ),
                    DetailItem(
                      label: LocaleKeys.flow_include.tr,
                      value: boolToString(item['include'])
                    ),
                  ],
                  DetailItem(
                    label: LocaleKeys.common_notes.tr,
                    value: item['notes'],
                    crossAlign: CrossAxisAlignment.start,
                  ),
                  FlowFileList(controller: controller),
                  const SizedBox(height: 15),
                  ..._actionBar(context, controller.item),
                ],
              )
            );
          default:
            return const ErrorPage();
        }
      }),
    );
  }

  List<Widget> _actionBar(BuildContext context, Map<String, dynamic> item) {
    return [
      if (item['type'] != 'ADJUST') ...[
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Get.put(FlowFormController(item['type'], 3, item));
              Get.to(() => const FlowFormPage(), fullscreenDialog: true)?.then(
                (value) => Get.delete<FlowFormController>()
              );
            },
            icon: const Icon(Icons.copy, size: 15),
            label: Text(LocaleKeys.common_copy.tr),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Get.put(FlowFormController(item['type'], 4, item));
              Get.to(() => const FlowFormPage(), fullscreenDialog: true)?.then(
                      (value) => Get.delete<FlowFormController>()
              );
            },
            icon: const Icon(Icons.undo, size: 15),
            label: Text(LocaleKeys.flow_refund.tr)
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          child: DialogConfirm(
              content: LocaleKeys.common_confirmDialogTitle.tr,
              enable: item['confirm'] != null && !item['confirm'],
              child: AbsorbPointer(
                child: ElevatedButton.icon(
                  onPressed: (item['confirm'] != null && !item['confirm']) ? () { } : null,
                  icon: const Icon(Icons.done, size: 15),
                  label: Text(LocaleKeys.flow_confirmBtn.tr),
                ),
              ),
              onConfirm: () {
                Get.find<FlowDetailController>().confirm();
              }
          ),
        ),
        const SizedBox(height: 5),
      ],
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            if (item['type'] == 'ADJUST') {
              Get.put(AccountAdjustController(2, item));
              Get.to(() => const AccountAdjustPage(), fullscreenDialog: true)?.then(
                (value) => Get.delete<AccountAdjustController>()
              );
            } else {
              Get.put(FlowFormController(item['type'], 2, item));
              Get.to(() => const FlowFormPage(), fullscreenDialog: true)?.then(
                (value) => Get.delete<FlowFormController>()
              );
            }
          },
          icon: const Icon(Icons.edit, size: 15),
          label: Text(LocaleKeys.common_edit.tr)
        ),
      ),
      const SizedBox(height: 5),
      SizedBox(
        width: double.infinity,
        child: DialogConfirm(
            content: item['confirm'] ? LocaleKeys.flow_deleteConfirm.tr : LocaleKeys.common_deleteDialogTitle.tr,
            child: AbsorbPointer(
              child: ElevatedButton.icon(
                onPressed: () {  },
                icon: const Icon(Icons.delete, size: 15,),
                label: Text(LocaleKeys.common_delete.tr),
              ),
            ),
            onConfirm: () {
              Get.find<FlowDetailController>().delete();
            }
        ),
      ),
      const SizedBox(height: 5),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: Text(LocaleKeys.common_camera.tr),
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                            if (photo != null) {
                              Get.find<FlowDetailController>().uploadFile(photo.path);
                            }
                            Get.back();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: Text(LocaleKeys.common_gallery.tr),
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                            if (file != null) {
                              Get.find<FlowDetailController>().uploadFile(file.path);
                            }
                            Get.back();
                          },
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          leading: const Icon(Icons.cancel),
                          title: Text(LocaleKeys.common_cancel.tr),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  }
              );
            },
            icon: const Icon(Icons.attachment, size: 15),
            label: Text(LocaleKeys.flow_addFile.tr)
        ),
      ),
    ];
  }

}