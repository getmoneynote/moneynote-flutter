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
        'value': 'default',
        'label': LocaleKeys.theme_default.tr,
        'theme': lightTheme,
        'selected': current == 'default'
      },
      {
        'name': 'red',
        'value': 'red',
        'label': LocaleKeys.theme_red.tr,
        'theme': redTheme,
        'selected': current == 'red'
      },
      {
        'name': 'orange',
        'value': 'orange',
        'label': LocaleKeys.theme_orange.tr,
        'theme': orangeTheme,
        'selected': current == 'orange'
      },
      {
        'name': 'yellow',
        'value': 'yellow',
        'label': LocaleKeys.theme_yellow.tr,
        'theme': yellowTheme,
        'selected': current == 'yellow'
      },
      {
        'name': 'green',
        'value': 'green',
        'label': LocaleKeys.theme_green.tr,
        'theme': greenTheme,
        'selected': current == 'green'
      },
      {
        'name': 'cyan',
        'value': 'cyan',
        'label': LocaleKeys.theme_cyan.tr,
        'theme': cyanTheme,
        'selected': current == 'cyan'
      },
      {
        'name': 'purple',
        'value': 'purple',
        'label': LocaleKeys.theme_purple.tr,
        'theme': purpleTheme,
        'selected': current == 'purple'
      },
      {
        'name': 'deepPurple',
        'value': 'deepPurple',
        'label': LocaleKeys.theme_deepPurple.tr,
        'theme': deepPurpleTheme,
        'selected': current == 'deepPurple'
      },
      {
        'name': 'brown',
        'value': 'brown',
        'label': LocaleKeys.theme_brown.tr,
        'theme': brownTheme,
        'selected': current == 'brown'
      },
      {
        'name': 'pink',
        'value': 'pink',
        'label': LocaleKeys.theme_pink.tr,
        'theme': pinkTheme,
        'selected': current == 'pink'
      },
      {
        'name': 'dark',
        'value': 'dark',
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