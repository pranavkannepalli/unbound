import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData unboundTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD0F4DE)),
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.getFont("Raleway").copyWith(fontSize: 16.0, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.getFont("Raleway").copyWith(fontSize: 12.0, fontWeight: FontWeight.bold),
    labelLarge: GoogleFonts.getFont("Raleway").copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.getFont("DM Serif Text").copyWith(fontSize: 36.0),
    titleMedium: GoogleFonts.getFont("Raleway").copyWith(fontSize: 16.0, fontWeight: FontWeight.w500),
  ),
);
