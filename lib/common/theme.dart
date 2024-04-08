import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData uboundTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD0F4DE)),
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.getFont("Raleway").copyWith(fontSize: 16.0, fontWeight: FontWeight.w500),
    titleLarge: GoogleFonts.getFont("Raleway").copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.getFont("DM Serif Text").copyWith(fontSize: 36.0),
    titleSmall: GoogleFonts.getFont("DM Serif Text").copyWith(fontSize: 20.0),
  ),
);
