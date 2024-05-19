import 'package:flutter/material.dart';

class AppColors {
  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 ||
        (hexString.length == 7 && hexString[0] == '#')) {
      buffer.write('ff');
      if (hexString.length == 7) {
        buffer.write(hexString.substring(1));
      } else {
        buffer.write(hexString);
      }
    } else if (hexString.length == 8 ||
        (hexString.length == 9 && hexString[0] == '#')) {
      if (hexString.length == 9) {
        buffer.write(hexString.substring(1));
      } else {
        buffer.write(hexString);
      }
    } else {
      throw const FormatException(
        "Invalid hex color format. Expected format: #RRGGBB or #AARRGGBB.",
      );
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color colorDarkGray = const Color(0xFF303030); // Dark Gray
  static Color colorWhite = const Color(0xFFFFFFFF); // White
  static Color colorWhiteSmoke = const Color(0xFFF5F5F5); // White Smoke
  static Color colorGray = const Color(0xFF808080); // Gray
  static Color colorOliveDrab = const Color(0xFF4E5A37); // Olive Drab
  static Color colorCharcoal = const Color(0xFF242424); // Charcoal
  static Color colorLightGray = const Color(0xFF999999); // Light Gray
  static Color colorGhostWhite = const Color(0xFFF8F8F8); // Ghost White
  static Color colorGainsboro = const Color(0xFFF0F0F0); // Gainsboro
  static Color colorSpanishGray = const Color(0xFF9C9C9C); // Spanish Gray
  static Color colorEerieBlack = const Color(0xFF1B1B1B); // Eerie Black
  static Color colorDeepTeal = const Color(0xFF133840); // Deep Teal
  static Color colorPlatinum = const Color(0xFFE0E0E0); // Platinum
  static Color colorSandyBrown = const Color(0xFFFFC567); // Sandy Brown
  static Color colorTaupeGray = const Color(0xFF9A9A9A); // Taupe Gray
  static Color colorDavyGray = const Color(0xFF4F4F4F); // Davy Gray
}
