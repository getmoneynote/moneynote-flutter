import 'package:get/get.dart';
import '../../../core/utils/theme.dart';
import '/generated/locales.g.dart';
import '/theme.dart';

import '/app/core/base/base_controller.dart';

class ThemeController extends BaseController {

  late List<Map<String, dynamic>> themes;
  String current = 'default';

  @override
  void onInit() {
    super.onInit();
    initTheme();
    setCurrent();
  }

  void setCurrent() async {
    String currentThemeStr = await Theme.get();
    if (currentThemeStr.isEmpty) {
      currentThemeStr = 'default';
    }
    var currentTheme = themes.firstWhere((e) => e['name'] == currentThemeStr);
    Get.changeTheme(currentTheme['theme']);
    current = currentTheme['name'];
    initTheme();
  }

  String currentLabel() {
    var currentTheme = themes.firstWhere((e) => e['name'] == current);
    return currentTheme['label'];
  }

  void initTheme() {
    themes = [
      {
        'name': 'default',
        'label': LocaleKeys.theme_default.tr,
        'theme': lightTheme,
        'selected': current == 'default'
      },
      {
        'name': 'purple',
        'label': LocaleKeys.theme_purple.tr,
        'theme': purpleTheme,
        'selected': current == 'purple'
      },
      {
        'name': 'red',
        'label': LocaleKeys.theme_red.tr,
        'theme': redTheme,
        'selected': current == 'red'
      },
      {
        'name': 'green',
        'label': LocaleKeys.theme_green.tr,
        'theme': greenTheme,
        'selected': current == 'green'
      },
      {
        'name': 'dark',
        'label': LocaleKeys.theme_dark.tr,
        'theme': darkTheme,
        'selected': current == 'dark'
      }
    ];
  }

  void changeTheme(name, theme) {
    current = name;
    Get.changeTheme(theme);
    if(Get.isBottomSheetOpen ?? false){
      Get.back();
    }
    update();
    Theme.save(name);
    initTheme();
  }

}