import 'package:flutter/material.dart';
import 'package:messenger_demo/core/strings/hive_strings.dart';

class GlobalTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    splashFactory: InkRipple.splashFactory,
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    splashFactory: InkRipple.splashFactory,
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
  );

  static ThemeMode getTheme(String data) {
    switch (data) {
      case HiveStrings.themeLight:
        return ThemeMode.light;
      case HiveStrings.themeDark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
