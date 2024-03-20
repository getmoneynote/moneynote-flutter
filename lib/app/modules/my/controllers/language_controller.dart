import 'dart:ui';
import 'package:get/get.dart';
import '../../../network/http.dart';
import '/app/modules/my/controllers/theme_controller.dart';
import '/app/core/utils/language.dart';
import '/app/core/base/base_controller.dart';

class LanguageController extends BaseController {

  late List<Map<String, dynamic>> languages;
  String current = 'en_US';

  @override
  void onInit() {
    super.onInit();
    initLang();
    setCurrent();
  }

  void setCurrent() async {
    String currentLang = await Language.get();
    if (currentLang.isEmpty) {
      currentLang = 'en_US';
    }
    var currentLanguage = languages.firstWhere((e) => e['name'] == currentLang);
    Get.updateLocale(currentLanguage['locale']);
    current = currentLanguage['name'];
    initLang();
    Get.find<ThemeController>().initTheme();
  }

  void initLang() {
    languages = [
      {
        'name': 'en_US',
        'label': '🇺🇸 English',
        'locale': const Locale('en', 'US'),
        'selected': current == 'en_US',
      },
      {
        'name': 'zh_CN',
        'label': '🇨🇳 简体中文',
        'locale': const Locale('zh', 'CN'),
        'selected': current == 'zh_CN',
      },
    ];
  }

  void changeLang(name, locale) {
    current = name;
    Get.updateLocale(locale);
    if(Get.isBottomSheetOpen ?? false){
      Get.back();
    }
    Get.find<ThemeController>().initTheme();
    Http.init();
    Language.save(name);
    initLang();
  }

}