import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '../../controllers/login_controller.dart';

class UsernameInput extends StatelessWidget {

  const UsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return TextField(
        onChanged: (value) { Get.find<LoginController>().usernameChanged(value); },
        decoration: InputDecoration(
          hintText: LocaleKeys.user_usernamePlaceholder.tr,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          errorText: (controller.usernameFormz.isPure || controller.usernameFormz.isValid) ? null : LocaleKeys.user_usernameErrorText.tr,
        ),
      );
    });
  }

}