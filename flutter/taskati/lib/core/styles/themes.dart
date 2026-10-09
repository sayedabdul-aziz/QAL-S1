import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    fontFamily: AppFonts.poppins,
    scaffoldBackgroundColor: LightPalette.background,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: LightPalette.primaryColor,
    hoverColor: DarkPalette.primaryColor100,
    appBarTheme: AppBarTheme(
      backgroundColor: LightPalette.background,
      foregroundColor: LightPalette.textPrimary,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyles.title2.copyWith(
        color: LightPalette.textPrimary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.caption1.copyWith(color: LightPalette.greyColor),
      fillColor: LightPalette.background,
      filled: true,
      errorStyle: TextStyles.caption2.copyWith(color: LightPalette.redColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: LightPalette.primaryColor, // app theme color
      onSurface: LightPalette.textPrimary, // Text color
      error: LightPalette.redColor,
      inversePrimary: LightPalette.textInverse,
      secondary: LightPalette.secondaryColor,
      tertiary: LightPalette.greyColor,
      surfaceContainer: DarkPalette.textPrimary,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: LightPalette.background,
      surfaceTintColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: LightPalette.primaryColor,
      unselectedItemColor: LightPalette.textPrimary,
      selectedLabelStyle: TextStyles.caption1.copyWith(
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyles.caption1.copyWith(
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    fontFamily: AppFonts.poppins,
    scaffoldBackgroundColor: DarkPalette.background,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: DarkPalette.primaryColor,
    hoverColor: DarkPalette.primaryColor100,
    appBarTheme: AppBarTheme(
      backgroundColor: DarkPalette.background,
      foregroundColor: DarkPalette.textPrimary,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyles.title2.copyWith(
        color: DarkPalette.textPrimary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.caption1.copyWith(color: DarkPalette.greyColor),
      fillColor: DarkPalette.background,
      filled: true,
      errorStyle: TextStyles.caption2.copyWith(color: DarkPalette.redColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),

    datePickerTheme: DatePickerThemeData(
      backgroundColor: DarkPalette.background,
      surfaceTintColor: Colors.transparent,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: DarkPalette.background,
      dialBackgroundColor: DarkPalette.background,
      hourMinuteColor: DarkPalette.background,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: DarkPalette.primaryColor, // app theme color
      onSurface: DarkPalette.textPrimary, // Text color
      error: LightPalette.redColor,
      inversePrimary: DarkPalette.textInverse,
      secondary: LightPalette.secondaryColor,
      tertiary: LightPalette.greyColor,
      surfaceContainer: DarkPalette.textPrimary,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: DarkPalette.primaryColor,
      unselectedItemColor: DarkPalette.textPrimary,
      selectedLabelStyle: TextStyles.caption1.copyWith(
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyles.caption1.copyWith(
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
