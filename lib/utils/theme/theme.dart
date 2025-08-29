import 'package:flutter/material.dart';
import 'package:job_portal/utils/theme/custom_themes/color_theme.dart';
import 'package:job_portal/utils/theme/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.light,
    scaffoldBackgroundColor: TColors.backgroundLight,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.lightTextTheme.apply(
      bodyColor: TColors.textPrimary,
      displayColor: TColors.textPrimary,
    ),
    colorScheme: const ColorScheme.light(
      primary: TColors.primary,
      secondary: TColors.secondary,
      surface: TColors.backgroundLight,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: TColors.backgroundDark,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.darkTextTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    colorScheme: const ColorScheme.dark(
      primary: TColors.primary,
      secondary: TColors.secondary,
      surface: TColors.backgroundDark,
    ),
  );
}
