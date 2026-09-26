import 'package:auto_sparkle/common/constants.dart';
import 'package:auto_sparkle/common/helpers/color_helper.dart';
import 'package:flutter/material.dart';

class ThemesCommon {
  // Color Scheme
  static final primaryColor = ColorHelper.fromHex('#FF0000');
  static const onPrimaryColor = Colors.white;
  static final secondaryColor = ColorHelper.fromHex('#505050');
  static const onSecondaryColor = Colors.white;
  static const lightTertiaryColor = Colors.black;
  static const darkTertiaryColor = Colors.white;
  static const lightScaffoldBackgroundColor = Colors.white;
  static const darkScaffoldBackgroundColor = Colors.black;

  // Text
  static const primaryText = FontFamily.PRIMARY;
  static const secondaryText = FontFamily.SECONDARY;

  // Methods
  static WidgetStateProperty<Color?> buildCheckboxCheckColor() {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) => ThemesCommon.darkTertiaryColor,
    );
  }

  static WidgetStateProperty<Color?> buildSwitchThumbColor() {
    return WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return ThemesCommon.darkTertiaryColor;
        }
        return ThemesCommon.lightTertiaryColor;
      },
    );
  }
}
