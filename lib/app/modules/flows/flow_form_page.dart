import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneynote/app/core/utils/utils.dart';
import 'package:moneynote/app/modules/flows/widgets/form/transfer_amount.dart';
import '/generated/locales.g.dart';
import 'widgets/form/index.dart';
import 'controllers/flow_form_controller.dart';


class FlowFormPage extends StatefulWidget {

  const FlowFormPage({super.key});

  @override
  State<FlowFormPage> createState() => _FlowFormPageState();

}


class _FlowFormPageState extends State<FlowFormPage> with TickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    tabController.addListener(() {
      if(!tabController.indexIsChanging) {
        Get.find<FlowFormController>().tabClick(tabController.index);
      }
    });
  }

  Widget _buildTitle(BuildContext context, int action, String type) {
    if (action == 1) {
      return TabBar(
        controller: tabController,
        labelPadding: const EdgeInsets.all(0),
        tabs: [
          Tab(text: LocaleKeys.flow_type1.tr),
          Tab(text: LocaleKeys.flow_type2.tr),
          Tab(text: LocaleKeys.flow_type3.tr),
        ],
      );
    } else {
      //return Text(translateAction(widget.action) + translateFlowType(widget.currentRow['type']));
      return Text(LocaleKeys.common_formTitle.trParams({
        'action': translateAction(action),
        'name': flowTypeToName(type)
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowFormController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: _buildTitle(context, controller.action, controller.type),
          actions: [
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: controller.valid ? () {
                Get.find<FlowFormController>().submit();
              } : null,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
            child: Wrap(
              runSpacing: 5,
              children: [
                Book(controller: controller),
                FormTitle(controller: controller),
                CreateTime(controller: controller),
                Account(controller: controller),
                if (controller.type == 'EXPENSE' || controller.type  == 'INCOME') ...[
                  Category(controller: controller),
                  Amount(controller: controller),
                  Payee(controller: controller)
                ],
                if (controller.type == 'TRANSFER') ...[
                  ToAccount(controller: controller),
                  TransferAmount(controller: controller)
                ],
                FormTag(controller: controller),
                Confirm(controller: controller),
                Include(controller: controller),
                Notes(controller: controller),
                const SizedBox(height: 70),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    onPressed: controller.valid ? () {
                      Get.find<FlowFormController>().submit();
                    } : null,
                    label: Text(LocaleKeys.common_submit.tr)
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      Get.find<FlowFormController>().reset();
                    },
                    label: Text(LocaleKeys.common_reset.tr)
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

}