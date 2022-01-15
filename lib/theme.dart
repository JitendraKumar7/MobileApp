import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//primaryColor: const Color(0xFF00BCD4),
//primaryColorDark: const Color(0xFF0097A7),
//primaryColorLight: const Color(0xFFB2EBF2),
//colorScheme: const ColorScheme.light(secondary: Color(0xFF009688)),
//scaffoldBackgroundColor: const Color(0xFFE0F2F1),
final theme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: GoogleFonts.openSansTextTheme(),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(9),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(9),
    ),
  ),
);
