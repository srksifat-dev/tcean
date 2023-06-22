import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  // static const Color kSecondary = Color(0xff56CCF2);
  // static const Color kOceanLight = Color.fromARGB(255, 164, 232, 255);
  // static const Color kPrimary = Color(0xff2F7FED);
  // static const Color kTertiary = Color(0xff40514e);

  // static const Color kRed = Color(0xfffc5185);
  // static const Color kRedLight = Color(0xfffdaed8);
  // static const Color kNeutral = Color(0xfff5f5f5);
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF005CBB),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD7E2FF),
  onPrimaryContainer: Color(0xFF001B3F),
  secondary: Color(0xFF006780),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFB7EAFF),
  onSecondaryContainer: Color(0xFF001F28),
  tertiary: Color(0xFF006A61),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFF73F8E7),
  onTertiaryContainer: Color(0xFF00201D),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF8FDFF),
  onBackground: Color(0xFF001F25),
  surface: Color(0xFFF8FDFF),
  onSurface: Color(0xFF001F25),
  surfaceVariant: Color(0xFFE0E2EC),
  onSurfaceVariant: Color(0xFF44474E),
  outline: Color(0xFF74777F),
  onInverseSurface: Color(0xFFD6F6FF),
  inverseSurface: Color(0xFF00363F),
  inversePrimary: Color(0xFFABC7FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF005CBB),
  outlineVariant: Color(0xFFC4C6D0),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFABC7FF),
  onPrimary: Color(0xFF002F66),
  primaryContainer: Color(0xFF00458F),
  onPrimaryContainer: Color(0xFFD7E2FF),
  secondary: Color(0xFF5DD5FC),
  onSecondary: Color(0xFF003543),
  secondaryContainer: Color(0xFF004E61),
  onSecondaryContainer: Color(0xFFB7EAFF),
  tertiary: Color(0xFF52DBCB),
  onTertiary: Color(0xFF003732),
  tertiaryContainer: Color(0xFF005049),
  onTertiaryContainer: Color(0xFF73F8E7),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001F25),
  onBackground: Color(0xFFA6EEFF),
  surface: Color(0xFF001F25),
  onSurface: Color(0xFFA6EEFF),
  surfaceVariant: Color(0xFF44474E),
  onSurfaceVariant: Color(0xFFC4C6D0),
  outline: Color(0xFF8E9099),
  onInverseSurface: Color(0xFF001F25),
  inverseSurface: Color(0xFFA6EEFF),
  inversePrimary: Color(0xFF005CBB),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFABC7FF),
  outlineVariant: Color(0xFF44474E),
  scrim: Color(0xFF000000),
);
