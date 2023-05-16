import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  var lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins().copyWith(
        color: AppColors.kBlue,
        fontSize: 30,
      ),
      // backgroundColor: AppColors.kBackground,
    ),
    // scaffoldBackgroundColor: AppColors.kBackground,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins().copyWith(
        fontWeight: FontWeight.bold,
        // color: AppColors.kBlue,
        fontSize: 25,
      ),
      titleMedium: GoogleFonts.poppins().copyWith(
        fontWeight: FontWeight.bold,
        // color: AppColors.kBlue,
        fontSize: 20,
      ),
      titleSmall: GoogleFonts.poppins().copyWith(
        fontWeight: FontWeight.bold,
        // color: AppColors.kBlue,
        fontSize: 15,
      ),
      bodyLarge: GoogleFonts.poppins().copyWith(
        // color: AppColors.kBlue,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.poppins().copyWith(
        // color: AppColors.kBlue,
        fontSize: 18,
      ),
      bodySmall: GoogleFonts.poppins().copyWith(
        // color: AppColors.kBlue,
        fontSize: 15,
      ),
      headlineLarge: GoogleFonts.josefinSans().copyWith(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        // color: AppColors.kBlue,
      ),
      headlineMedium: GoogleFonts.josefinSans().copyWith(
        fontWeight: FontWeight.bold,
        // color: AppColors.kBlue,
        fontSize: 40,
      ),
      headlineSmall: GoogleFonts.josefinSans().copyWith(
        fontWeight: FontWeight.bold,
        // color: AppColors.kBlue,
        fontSize: 30,
      ),
      displayMedium: GoogleFonts.josefinSans().copyWith(
        fontWeight: FontWeight.bold,
        // color: AppColors.kSkyBlue,
        fontSize: 20,
      ),
      displayLarge: GoogleFonts.josefinSans().copyWith(
        fontWeight: FontWeight.bold,
        // color: AppColors.kSkyBlue,
        fontSize: 30,
      ),
    ),
    sliderTheme: SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
  );

  // Dark Theme
  var darkTheme = ThemeData.dark(useMaterial3: true);
}
