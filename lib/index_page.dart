import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneynote/app/modules/my/controllers/api_version_controller.dart';
import '/app/modules/charts/charts_controller.dart';
import '/app/modules/my/controllers/account_overview_controller.dart';
import '/app/modules/accounts/controllers/accounts_controller.dart';
import '/app/modules/charts/charts_page.dart';
import '/app/modules/flows/controllers/flows_controller.dart';
import '/app/modules/flows/flows_page.dart';
import '/app/modules/my/my_page.dart';
import '/app/core/values/app_text_styles.dart';
import '/app/core/components/lazy_indexed_stack.dart';
import '/app/modules/accounts/ui/accounts_page.dart';
import '/generated/locales.g.dart';
import 'app/modules/flows/controllers/flow_form_controller.dart';
import 'app/modules/flows/flow_form_page.dart';

class IndexPage extends StatefulWidget {

  final int initialIndex;

  const IndexPage({
    super.key,
    this.initialIndex = 1,
  });

  @override
  State<IndexPage> createState() => _IndexPageState();

}

class _IndexPageState extends State<IndexPage> {

  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    super.initState();
  }

  Widget buildBottomItem(int index, IconData iconData, String label) {
    final theme = Theme.of(context);
    Color color = _selectedIndex == index ? theme.colorScheme.primary : theme.unselectedWidgetColor;
    return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: SizedBox(
          width: 66,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, color: color),
              Text(label, style: TextStyle(color: color))
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: LazyIndexedStack(
          reuse: true,
          index: _selectedIndex,
          itemBuilder: (c, i) {
            switch (i) {
              case 0:
                Get.put(AccountsController());
                return const AccountsPage();
              case 1:
                Get.put(FlowsController());
                return const FlowsPage();
              case 2:
                Get.put(ChartsController());
                return const ChartsPage();
              case 3:
                Get.put(AccountOverviewController());
                Get.put(ApiVersionController());
                return const MyPage();
            }
            throw Exception('index page error');
          },
          itemCount: 4,
        ),
        bottomNavigationBar: Container(
            height: 56,
            margin: const EdgeInsets.symmetric(vertical: 0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: theme.unselectedWidgetColor),
              ),
            ),
            child: Row(
                children: [
                  buildBottomItem(0, Icons.account_balance_outlined, LocaleKeys.menu_account.tr),
                  buildBottomItem(1, Icons.table_rows_outlined, LocaleKeys.menu_flow.tr),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.put(FlowFormController('EXPENSE', 1, { }));
                        Get.to(() => const FlowFormPage(), fullscreenDialog: true)?.then(
                          (value) => Get.delete<FlowFormController>()
                        );
                      },
                      child: Container(
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          LocaleKeys.menu_newFlow.tr,
                          style: AppTextStyle.newFlow.copyWith(color: theme.colorScheme.onPrimary)
                        ),
                      ),
                    ),
                  ),
                  buildBottomItem(2, Icons.pie_chart_outline, LocaleKeys.menu_chart.tr),
                  buildBottomItem(3, Icons.person_outline_outlined, LocaleKeys.menu_my.tr),
                ]
            )
        )
    );
  }
}
