import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '../../controllers/login_controller.dart';

class PasswordInput extends StatelessWidget {

  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return TextField(
        obscureText: true,
        obscuringCharacter: "*",
        enableSuggestions: false,
        autocorrect: false,
        onChanged: (value) { Get.find<LoginController>().passwordChanged(value); },
        decoration: InputDecoration(
          hintText: LocaleKeys.user_passwordPlaceholder.tr,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          errorText: (controller.passwordFormz.isPure || controller.passwordFormz.isValid) ? null : LocaleKeys.user_passwordErrorText.tr,
        ),
      );
    });
  }

}