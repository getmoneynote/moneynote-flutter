import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneynote/app/modules/my/controllers/api_version_controller.dart';
import '../common/select/select_controller.dart';
import '../common/select/select_option.dart';
import '/app/modules/my/controllers/account_overview_controller.dart';
import '/app/core/base/enums.dart';
import '/app/core/components/bottomsheet_container.dart';
import '/app/core/values/app_values.dart';
import '/app/modules/my/controllers/language_controller.dart';
import '/app/modules/my/controllers/theme_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/components/dialog_confirm.dart';
import '../login/controllers/auth_controller.dart';

class MyPage extends StatelessWidget {

  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.menu_my.tr),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                  title: Text(LocaleKeys.my_userName.tr),
                  trailing: GetBuilder<AuthController>(builder: (controller) {
                    return Text(controller.initState['user']?['username'] ?? '');
                  }),
              ),
              const Divider(),
              ListTile(
                title: Text(LocaleKeys.my_accountOverview.tr),
                subtitle: GetBuilder<AccountOverviewController>(builder: (controller) {
                  if (controller.status == LoadDataStatus.success) {
                    return Text(
                      LocaleKeys.my_accountOverviewDesc.trParams({
                        'asset': controller.data[0].toStringAsFixed(2),
                        'debt': controller.data[1].toStringAsFixed(2),
                        'net': controller.data[2].toStringAsFixed(2)
                      }),
                      style: const TextStyle(fontSize: 12),
                      softWrap: true,
                    );
                  }
                  return const Text('Loading...');
                }),
                trailing: IconButton(
                  onPressed: () {
                    Get.find<AccountOverviewController>().load();
                  },
                  icon: const Icon(Icons.refresh)
                )
              ),
              const Divider(),
              GetBuilder<AuthController>(builder: (controller) {
                dynamic group = controller.initState['group'];
                dynamic book = controller.initState['book'];
                return ListTile(
                  title: Text(LocaleKeys.my_currentBook.tr),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${group['name']}(${group['defaultCurrencyCode']})-${book['name']}(${book['defaultCurrencyCode']})'),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                  onTap: () {
                    Get.find<SelectController>().load('bookSelect');
                    Get.to(() => SelectOption(
                      title: LocaleKeys.my_currentBook.tr,
                      value: {
                        'value': '${controller.initState['group']['id']}-${controller.initState['book']['id']}'
                      },
                      onSelect: (value) async {
                        Get.back();
                        Get.find<AuthController>().changeCurrentBook(value['value']);
                      },
                    ));
                  },
                );
              }),
              const Divider(),
              GetBuilder<ThemeController>(builder: (controller) {
                return ListTile(
                  title: Text(LocaleKeys.my_currentTheme.tr),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(controller.currentLabel()),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                  onTap: () {
                    Get.find<SelectController>().loadStatic(controller.themes);
                    Get.to(() => SelectOption(
                      title: LocaleKeys.my_currentTheme.tr,
                      value: controller.themes.firstWhere((e) => e['name'] == controller.current),
                      onSelect: (value) async {
                        Get.back();
                        Get.find<ThemeController>().changeTheme(value['value'], value['theme']);
                      },
                    ));
                    // Get.bottomSheet(
                    //   BottomSheetContainer(child: GetBuilder<ThemeController>(builder: (controller) {
                    //     return Wrap(
                    //       children: controller.themes.map((e) =>
                    //           ListTile(
                    //             title: Text(e['label']),
                    //             onTap: () {
                    //               Get.find<ThemeController>().changeTheme(e['name'], e['theme']);
                    //             },
                    //             selected: e['selected'],
                    //           )
                    //       ).toList(),
                    //     );
                    //   }))
                    // );
                  },
                );
              }),
              const Divider(),
              ListTile(
                title: Text(LocaleKeys.my_currentLang.tr),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Builder(builder: (BuildContext context) {
                      String locale = Get.locale?.toString() ?? '';
                      if (locale == 'en_US') {
                        return const Text("🇺🇸 English");
                      } else if (locale == 'zh_CN') {
                        return const Text("🇨🇳 简体中文");
                      }
                      return const Text("Not Found");
                    }),
                    const Icon(Icons.keyboard_arrow_right)
                  ],
                ),
                onTap: () {
                  Get.bottomSheet(
                    BottomSheetContainer(child: GetBuilder<LanguageController>(builder: (controller) {
                      return Wrap(
                        children: controller.languages.map((e) =>
                          ListTile(
                            title: Text(e['label']),
                            onTap: () {
                              Get.find<LanguageController>().changeLang(e['name'], e['locale']);
                            },
                            selected: e['selected'],
                          )
                        ).toList(),
                      );
                    }))
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('API: '),
                trailing: Text(AppValues.apiUrl)
              ),
              const Divider(),
              ListTile(
                title: Text(LocaleKeys.my_currentVersion.tr),
                trailing: const Text(AppValues.version)
              ),
              const Divider(),
              ListTile(
                title: Text(LocaleKeys.my_apiVersion.tr),
                trailing: GetBuilder<ApiVersionController>(builder: (controller) {
                  return Text(controller.version);
                })
              ),
              const Divider(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: DialogConfirm(
                  child: AbsorbPointer(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      onPressed: () { },
                      label: Text(LocaleKeys.my_logout.tr),
                    ),
                  ),
                  onConfirm: () {
                    Get.find<AuthController>().onLoggedOut();
                  }
                )
              ),
              const SizedBox(height: 30),
            ],
          ),
        )
    );
  }
}