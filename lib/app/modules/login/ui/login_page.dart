import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../my/controllers/language_controller.dart';
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
              Text(AppValues.version, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }

}