import 'package:flutter/material.dart';
import 'start_page.dart';
import 'index.dart';

class AppRouter {

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const StartPage(),
    '/index': (context) => const IndexPage(),
  };



}