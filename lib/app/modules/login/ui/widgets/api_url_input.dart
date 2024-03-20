import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '../../controllers/login_controller.dart';

class ApiUrlInput extends StatelessWidget {

  const ApiUrlInput({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return TextField(
        controller: controller.apiController,
        onChanged: (value) { Get.find<LoginController>().apiChanged(value); },
        decoration: InputDecoration(
          hintText: LocaleKeys.user_apiPlaceholder.tr,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          errorText: (controller.apiFormz.isPure || controller.apiFormz.isValid) ? null : LocaleKeys.user_apiErrorText.tr,
        ),
      );
    });
  }

}