import 'package:auto_sparkle/common/themes/themes_common.dart';
import 'package:flutter/material.dart';

class LightThemes {
  static final ThemeData lightThemeDefault = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: ThemesCommon.secondaryText,
    scaffoldBackgroundColor: ThemesCommon.lightScaffoldBackgroundColor,
    primaryColor: ThemesCommon.primaryColor,
    colorScheme: ColorScheme.light(
      primary: ThemesCommon.primaryColor,
      onPrimary: ThemesCommon.onPrimaryColor,
      secondary: ThemesCommon.secondaryColor,
      onSecondary: ThemesCommon.onSecondaryColor,
    ),
    dividerColor: ThemesCommon.lightTertiaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ThemesCommon.primaryColor,
      foregroundColor: ThemesCommon.darkTertiaryColor,
      titleTextStyle: const TextStyle(
        fontFamily: ThemesCommon.primaryText,
        fontWeight: FontWeight.bold,
        color: ThemesCommon.darkTertiaryColor,
      ),
      toolbarTextStyle: const TextStyle(color: ThemesCommon.darkTertiaryColor),
      iconTheme: const IconThemeData(color: ThemesCommon.darkTertiaryColor),
      actionsIconTheme:
          const IconThemeData(color: ThemesCommon.darkTertiaryColor),
    ),
    iconTheme: const IconThemeData(color: ThemesCommon.lightTertiaryColor),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      filled: true,
      fillColor: ThemesCommon.lightScaffoldBackgroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        surfaceTintColor: WidgetStateProperty.all<Color>(Colors.transparent),
        backgroundColor:
            WidgetStateProperty.all<Color>(ThemesCommon.primaryColor),
        foregroundColor:
            WidgetStateProperty.all<Color>(ThemesCommon.lightTertiaryColor),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: const CircleBorder(),
      backgroundColor: ThemesCommon.primaryColor,
    ),
    cardTheme: const CardThemeData(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2,
      shape: RoundedRectangleBorder(),
      color: ThemesCommon.lightScaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: ThemesCommon.lightScaffoldBackgroundColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: ThemesCommon.darkScaffoldBackgroundColor,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: ThemesCommon.primaryColor,
      inactiveTrackColor: ThemesCommon.secondaryColor,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: ThemesCommon.buildSwitchThumbColor(),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ThemesCommon.lightScaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
    ),
    badgeTheme: BadgeThemeData(
      backgroundColor: ThemesCommon.primaryColor,
    ),
    textButtonTheme: const TextButtonThemeData(),
    checkboxTheme: CheckboxThemeData(
      checkColor: ThemesCommon.buildCheckboxCheckColor(),
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: ThemesCommon.lightScaffoldBackgroundColor,
      iconColor: ThemesCommon.lightTertiaryColor,
    ),
  );
}
