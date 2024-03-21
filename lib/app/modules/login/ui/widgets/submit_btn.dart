import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '../../controllers/login_controller.dart';

class SubmitBtn extends StatelessWidget {

  const SubmitBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return ElevatedButton.icon(
        icon: const Icon(Icons.login),
        onPressed: controller.valid ? () { controller.login(); } : null,
        label: Text(LocaleKeys.user_login.tr)
      );
    });
  }
}