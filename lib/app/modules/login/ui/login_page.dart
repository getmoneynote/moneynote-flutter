import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/bottomsheet_container.dart';
import './widgets/login_form.dart';
import '/app/core/values/app_values.dart';
import '/app/core/values/app_text_styles.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 50, bottom: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/logo.png', width: 50, height: 50),
                            const SizedBox(width: 20),
                            const Text(AppValues.appName, style: AppTextStyle.loginTitle),
                          ],
                        )
                    ),
                    const LoginForm(),
                  ],
                ),
              )
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.language, size: 32),
                onPressed: () {
                  String locale = Get.locale?.toString() ?? '';
                  Get.bottomSheet(
                    BottomSheetContainer(
                      child: Wrap(
                        children: [
                            ListTile(
                              title: const Text("🇺🇸 English"),
                              onTap: () {
                                Get.updateLocale(const Locale('en', 'US'));
                                if(Get.isBottomSheetOpen ?? false){
                                  Get.back();
                                }
                              },
                              selected: locale == 'en_US',
                            ),
                            ListTile(
                              title: const Text("🇨🇳 简体中文"),
                              onTap: () {
                                Get.updateLocale(const Locale('zh', 'CN'));
                                if(Get.isBottomSheetOpen ?? false){
                                  Get.back();
                                }
                              },
                              selected: locale == 'zh_CN',
                            )
                          ],
                      )
                    )
                  );
                },
              ),
              Text(AppValues.version, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }

}