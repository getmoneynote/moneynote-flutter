import 'dart:ui';
// https://aditya-rohman.medium.com/how-to-provide-localizations-feature-to-a-flutter-app-with-bloc-library-shared-preferences-2c2f4fc2fb8a

enum Language {

  english(
    Locale('en', 'US'),
    'English',
  ),

  chinese(
    Locale('zh', 'CN'),
    '简体中文',
  );

  const Language(this.value, this.text);

  final Locale value;
  final String text; // Optional: this properties used for ListTile details

}