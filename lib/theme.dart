import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  useMaterial3: false,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  useMaterial3: false,
);

ThemeData purpleTheme = ThemeData.light().copyWith(
  // primaryColor: Colors.deepPurple,
  useMaterial3: false,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
);

ThemeData greenTheme = ThemeData.light().copyWith(
  // primaryColor: Colors.deepPurple,
  useMaterial3: false,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
);

ThemeData redTheme = ThemeData.light().copyWith(
  // primaryColor: Colors.deepPurple,
  useMaterial3: false,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
);