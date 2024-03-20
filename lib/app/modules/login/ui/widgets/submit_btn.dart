import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:formz/formz.dart';
import '/generated/locales.g.dart';
import '../../controllers/login_controller.dart';

class SubmitBtn extends StatelessWidget {

  const SubmitBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return ElevatedButton(
          onPressed: controller.valid && !controller.submissionStatus.isInProgress ? () { controller.login(); } : null,
          child: controller.submissionStatus.isInProgress ?
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 1.5,
          ) : Text(LocaleKeys.user_login.tr)
      );
    });
  }
}