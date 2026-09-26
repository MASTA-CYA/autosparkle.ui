import 'package:flutter/material.dart';

class ColorHelper {
  /// Lighten a color by [percent] amount (100 = white).
  static Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final double p = percent / 100;
    return Color.from(
      alpha: c.a,
      red: c.r + (1 - c.r) * p,
      green: c.g + (1 - c.g) * p,
      blue: c.b + (1 - c.b) * p,
    );
  }

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
