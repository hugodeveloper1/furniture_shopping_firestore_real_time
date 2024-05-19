import 'package:flutter/material.dart';
import 'package:furniture_shopping_firestore_real_time/presentation/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData themeLight = ThemeData(
    scaffoldBackgroundColor: Colors.white,

    appBarTheme: AppBarTheme(
      titleSpacing: 15,
      elevation: 0,
      backgroundColor: AppColors.colorWhite,
      surfaceTintColor: AppColors.colorWhite,
      titleTextStyle: GoogleFonts.nunitoSans(
        color: AppColors.colorDarkGray,
        fontSize: 22,
        fontWeight: FontWeight.w800,
      ),
    ),

    // Styles
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.colorCharcoal,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.colorGray,
      ),
    ),
  );
}
