import 'package:get/get.dart';
import '/start_page.dart';
part 'app_routes.dart';

class AppPages {

  AppPages._();

  static const INITIAL = Routes.START;

  static final routes = [
    GetPage(
      name: _Paths.START,
      page: () => const StartPage(),
    ),
  ];

}