import 'package:auto_sparkle/common/constants.dart';
import 'package:flutter/material.dart';

class Functions {
  static double horizontalScreenMargin(BuildContext context) {
    return MediaQuery.of(context).size.width <= DeviceSize.TABLET_SCREEN_WIDTH
        ? 5
        : 100;
  }

  static bool hasTextOverflow({
    required String text,
    required TextStyle style,
    required double maxWidth,
    double minWidth = 0,
    int maxLines = 2,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);

    return textPainter.didExceedMaxLines;
  }
}
