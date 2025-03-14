import 'package:flutter/material.dart';
import 'package:messenger_demo/core/strings/hive_strings.dart';
import 'package:messenger_demo/core/theme/colors.dart';

class GlobalTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    splashFactory: InkRipple.splashFactory,
    fontFamily: 'Gilroy',
    primaryColor: AppColors.lightAppBarBackground,
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightAppBarBackground,
      foregroundColor: AppColors.lightPrimaryText,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightPrimaryText),
      bodyMedium: TextStyle(color: AppColors.lightPrimaryText),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimaryColor,
      secondary: AppColors.lightSecondaryText,
      surface: AppColors.lightChatBackground,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    splashFactory: InkRipple.splashFactory,
    fontFamily: 'Gilroy',
    primaryColor: AppColors.darkAppBarBackground,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkAppBarBackground,
      foregroundColor: AppColors.darkPrimaryText,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkPrimaryText),
      bodyMedium: TextStyle(color: AppColors.darkPrimaryText),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimaryColor,
      secondary: AppColors.lightSecondaryText,
      surface: AppColors.darkChatBackground,
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
