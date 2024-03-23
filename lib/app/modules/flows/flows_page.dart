import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '/app/core/components/order_button.dart';
import '/app/core/values/app_const.dart';
import '/app/modules/flows/flow_filter_page.dart';
import '/app/modules/flows/controllers/flows_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/base/enums.dart';
import '/app/core/components/pages/index.dart';
import '/app/core/utils/utils.dart';
import 'controllers/flow_detail_controller.dart';
import 'controllers/flow_form_controller.dart';
import 'flow_detail_page.dart';
import 'flow_form_page.dart';

class FlowsPage extends StatelessWidget {

  const FlowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.find<FlowsController>().reload();
            },
            icon: const Icon(Icons.refresh)
        ),
        centerTitle: true,
        title: Text(LocaleKeys.flow_listPageTitle.tr),
        actions: [
          GetBuilder<FlowsController>(builder: (controller) {
            return OrderButton(
              items: {
                'createTime,desc': LocaleKeys.flow_order1.tr,
                'amount,desc': LocaleKeys.flow_order2.tr,
              },
              selected: controller.query[AppConst.sortParameter] ?? '',
              onSelected: (value) {
                Get.find<FlowsController>().changeSort(value);
              },
            );
          }),
          IconButton(
            onPressed: () {
              Get.to(() => const FlowFilterPage(), fullscreenDialog: true);
            },
            icon: const Icon(Icons.search)
          )
        ],
      ),
      body: GetBuilder<FlowsController>(builder: (controller) {
        LoadDataStatus status = controller.status;
        switch (status) {
          case LoadDataStatus.progress:
          case LoadDataStatus.initial:
            return const LoadingPage();
          case LoadDataStatus.success:
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: controller.refreshController,
              child: buildContent(context, controller.items),
              onLoading: () async {
                Get.find<FlowsController>().loadMore();
              },
              onRefresh: () async {
                Get.find<FlowsController>().reload();
              },
            );
          case LoadDataStatus.empty:
            return const EmptyPage();
          case LoadDataStatus.failure:
            return const ErrorPage();
        }
      }),
    );
  }

  Widget buildContent(BuildContext context, List<Map<String, dynamic>> items) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> item = items.elementAt(index);
        TextStyle amountStyle = theme.textTheme.titleLarge ?? const TextStyle(fontWeight: FontWeight.w500, fontSize: 20);
        if (item['type'] == 'EXPENSE') amountStyle = amountStyle.copyWith(color: Colors.green);
        if (item['type'] == 'INCOME') amountStyle = amountStyle.copyWith(color: Colors.red);
        return ListTile(
          dense: false,
          title: Text(item['listTitle'], style: theme.textTheme.bodyLarge),
          subtitle: Text('${item["typeName"]} ${dateFormat(item["createTime"])} ${item["tagsName"]}', style: theme.textTheme.bodySmall),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item['amount'].toStringAsFixed(2), style: amountStyle),
                  if (item['accountName']?.isNotEmpty ?? false) Text(item['accountName'], style: theme.textTheme.bodySmall),
                ],
              ),
              const Icon(Icons.keyboard_arrow_right)
            ],
          ),
          onTap: () {
            Get.put(FlowDetailController(item['id']));
            Get.to(() => const FlowDetailPage())?.then((value) => Get.delete<FlowDetailController>());
          },
          onLongPress: () {
            Get.put(FlowFormController(item['type'], 3, item));
            Get.to(() => const FlowFormPage(), fullscreenDialog: true)?.then(
              (value) => Get.delete<FlowFormController>()
            );
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

}