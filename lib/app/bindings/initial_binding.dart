import 'package:get/get.dart';
import '/app/modules/common/select/select_controller.dart';
import '/app/modules/my/controllers/language_controller.dart';
import '/app/modules/my/controllers/theme_controller.dart';
import '/app/modules/login/controllers/auth_controller.dart';

class InitialBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(LanguageController());
    Get.put(ThemeController());
    Get.put(SelectController());
  }

}