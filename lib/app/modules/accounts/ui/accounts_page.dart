import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/accounts/controllers/account_form_controller.dart';
import '/app/modules/accounts/ui/account_detail_page.dart';
import '/app/modules/accounts/ui/account_form_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../controllers/account_detail_controller.dart';
import '/app/core/base/enums.dart';
import '/app/core/components/pages/index.dart';
import '/app/core/values/app_text_styles.dart';
import '/app/modules/accounts/controllers/accounts_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/utils/utils.dart';

class AccountsPage extends StatefulWidget {

  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();

}

class _AccountsPageState extends State<AccountsPage> with TickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    tabController.addListener(() {
      if(!tabController.indexIsChanging) {
        Get.find<AccountsController>().tabClick(tabController.index);
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.find<AccountsController>().reload();
              },
              icon: const Icon(Icons.refresh)
          ),
          centerTitle: true,
          title: TabBar(
            controller: tabController,
            labelPadding: const EdgeInsets.all(0),
            tabs: [
              Tab(child: Text(LocaleKeys.account_checking.tr, style: AppTextStyle.accountTab)),
              Tab(child: Text(LocaleKeys.account_credit.tr, style: AppTextStyle.accountTab)),
              Tab(child: Text(LocaleKeys.account_asset.tr, style: AppTextStyle.accountTab)),
              Tab(child: Text(LocaleKeys.account_debt.tr, style: AppTextStyle.accountTab)),
            ],
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Get.put(AccountFormController(accountTabIndexToType(tabController.index), 1, {}));
                  Get.to(() => const AccountFormPage(), fullscreenDialog: true)?.then(
                    (value) => Get.delete<AccountFormController>()
                  );
                }
            )
          ]
      ),
      body: GestureDetector(
        // https://flutterassets.com/flutter-gestures-detection/
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            if (tabController.index > 0) {
              tabController.animateTo(tabController.index - 1);
            }
          } else if (details.velocity.pixelsPerSecond.dx < 0) {
            if (tabController.index < 3) {
              tabController.animateTo(tabController.index + 1);
            }
          }
        },
        child: GetBuilder<AccountsController>(builder: (controller) {
          LoadDataStatus status = controller.status;
          switch (status) {
            case LoadDataStatus.progress:
            case LoadDataStatus.initial:
              return const LoadingPage();
            case LoadDataStatus.success:
              return SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                controller: controller.refreshController,
                child: buildContent(context, controller.items),
                onLoading: () async {
                  Get.find<AccountsController>().loadMore();
                },
              );
            case LoadDataStatus.empty:
              return const EmptyPage();
            case LoadDataStatus.failure:
              return const ErrorPage();
          }
        }),
      )
    );
  }

  Widget buildContent(BuildContext context, List<Map<String, dynamic>> items) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> item = items.elementAt(index);
        return ListTile(
          dense: true,
          title: Text(item['name'], style: theme.textTheme.bodyLarge),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item['balance'].toStringAsFixed(2), style: AppTextStyle.accountBalance),
              const Icon(Icons.keyboard_arrow_right)
            ],
          ),
          onTap: () {
            Get.put(AccountDetailController(item['id']));
            Get.to(() => const AccountDetailPage())?.then((value) => Get.delete<AccountDetailController>());
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

}