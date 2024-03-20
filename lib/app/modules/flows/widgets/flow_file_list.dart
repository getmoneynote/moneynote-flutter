import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/app/core/utils/message.dart';
import '/app/modules/flows/controllers/flow_detail_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/dialog_confirm.dart';
import '/app/core/components/web_view_page.dart';
import '../flow_repository.dart';

class FlowFileList extends StatelessWidget {

  final FlowDetailController controller;

  const FlowFileList({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    if (controller.fileItems.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 45,
          child: Center(
            child: Text(LocaleKeys.flow_file.tr, style: Theme.of(context).textTheme.bodyMedium)
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: controller.fileItems.map((e) => (
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          if (e['contentType'] == 'application/pdf') {
                            Message.error(LocaleKeys.flow_pdfError.tr);
                            return;
                          }
                          Get.to(() => WebViewPage(title: LocaleKeys.flow_filePreviewTitle.tr, url: FlowRepository.buildUrl(e)));
                        },
                        child: Text(e['originalName']),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: FlowRepository.buildUrl(e))).then((_) => Message.success(LocaleKeys.common_operationSuccess.tr)
                      );
                    },
                    child: Text(LocaleKeys.flow_fileCopy.tr),
                  ),
                  DialogConfirm(
                    content: LocaleKeys.common_confirmDialogTitle.tr,
                    child: AbsorbPointer(
                      child: TextButton(
                        onPressed: () { },
                        child: Text(LocaleKeys.common_delete.tr),
                      ),
                    ),
                    onConfirm: () {
                      Get.find<FlowDetailController>().deleteFile(e['id']);
                    }
                  ),
                ],
              ))
            ).toList(),
          )
        ),
      ],
    );
  }

}