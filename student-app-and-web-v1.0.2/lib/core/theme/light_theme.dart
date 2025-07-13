import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Ubuntu',
  primaryColor: const Color(0xFF7455F7),
  primaryColorLight: const Color(0xFFF7F8FA),
  primaryColorDark: const Color(0xFF10324A),
  secondaryHeaderColor: const Color(0xFF9BB8DA),

  disabledColor: const Color(0xFF8797AB),
  scaffoldBackgroundColor: const Color(0xFFF7F8FA),
  brightness: Brightness.light,
  hintColor: const Color(0xFFC0BFBF),
  focusColor: const Color(0xFFFFF9E5),
  hoverColor: const Color(0xFFF1F7FC),
  shadowColor: const Color(0x211B7FED),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xFF0461A5))), colorScheme: const ColorScheme.light(primary: Color(0xFF056AB4), secondary: Color(0xFFFF9900), tertiary: Color(0xFFd35221)).copyWith(background: const Color(0xffFCFCFC)).copyWith(error: const Color(0xFFFF6767)),
);