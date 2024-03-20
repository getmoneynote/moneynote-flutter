import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/login/controllers/auth_controller.dart';
import '/app/core/components/pages/index.dart';
import '/app/modules/login/controllers/login_controller.dart';
import '/app/modules/login/ui/login_page.dart';
import 'index_page.dart';

class StartPage extends StatelessWidget {

  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      switch (controller.status) {
        case AuthStatus.uninitialized:
          return const LoadingPage();
        case AuthStatus.loading:
          return const LoadingPage();
        case AuthStatus.unauthenticated:
          Get.put(LoginController());
          return const LoginPage();
        case AuthStatus.authenticated:
          return const IndexPage();
      }
    });
  }
}
