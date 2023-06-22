import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



var textTheme = TextTheme(
  bodyLarge: GoogleFonts.poppins().copyWith(fontSize: 25),
  bodyMedium: GoogleFonts.poppins().copyWith(fontSize: 20),
  bodySmall: GoogleFonts.poppins().copyWith(fontSize: 16),
  titleLarge: GoogleFonts.josefinSans()
      .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
  titleMedium: GoogleFonts.josefinSans()
      .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
  titleSmall: GoogleFonts.josefinSans()
      .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
);

var appBarTheme = AppBarTheme(
  titleTextStyle: GoogleFonts.josefinSans().copyWith(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  ),
);
