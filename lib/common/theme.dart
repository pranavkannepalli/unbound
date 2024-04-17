import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData unboundTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: purple),
  scaffoldBackgroundColor: white.shade50,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: Color(0xFF727272),
  ),
  textTheme: TextTheme(
    displayMedium: GoogleFonts.getFont("DM Serif Text").copyWith(fontSize: 36, fontWeight: FontWeight.w400),
    displaySmall: GoogleFonts.getFont("DM Serif Text").copyWith(fontSize: 20, fontWeight: FontWeight.w400),
    titleLarge: GoogleFonts.getFont("Poppins").copyWith(fontSize: 20, fontWeight: FontWeight.w600, height: 1.2),
    titleMedium: GoogleFonts.getFont("DM Serif Text").copyWith(fontSize: 16, height: 1.2, fontWeight: FontWeight.w400),
    titleSmall: GoogleFonts.getFont("DM Serif Text").copyWith(fontSize: 14, height: 1.2, fontWeight: FontWeight.w400),
    labelLarge: GoogleFonts.getFont("Poppins").copyWith(fontSize: 16, fontWeight: FontWeight.w600, height: 1.2),
    labelMedium: GoogleFonts.getFont("Poppins").copyWith(fontSize: 14, fontWeight: FontWeight.w600, height: 1.2),
    labelSmall: GoogleFonts.getFont("Poppins").copyWith(fontSize: 12, fontWeight: FontWeight.w600, height: 1.2),
    bodyLarge: GoogleFonts.getFont("Poppins").copyWith(fontSize: 16, fontWeight: FontWeight.w400, height: 1.2),
    bodyMedium: GoogleFonts.getFont("Poppins").copyWith(fontSize: 14, fontWeight: FontWeight.w400, height: 1.2),
    bodySmall: GoogleFonts.getFont("Poppins").copyWith(fontSize: 12, fontWeight: FontWeight.w400, height: 1.2)
  ),
);

const Map<int, Color> pinkSwatch = <int, Color>{
  50: Color(0xFFFFEBF4),
  100: Color(0xFFFFDDED),
  200: Color(0xFFFFBBDA),
  300: Color(0xFFFF99CB),
  400: Color(0xFFAA6685),
  500: Color(0xFF553343),
  600: Color(0xFF331F28)
};

const Map<int, Color> yellowSwatch = <int, Color>{
  50: Color(0xFFFEFDF2),
  100: Color(0xFFFEFCE9),
  200: Color(0xFFFDF9D3),
  300: Color(0xFFFCF68D),
  400: Color(0xFFDCD165),
  500: Color(0xFF9C9341),
  600: Color(0xFF323126)
};

const Map<int, Color> greenSwatch = <int, Color>{
  50: Color(0xFFF6FDF8),
  100: Color(0xFFEFFBF4),
  200: Color(0xFFE0F8E9),
  300: Color(0xFFD0F4DE),
  400: Color(0xFF8BA394),
  500: Color(0xFF45514A),
  600: Color(0xFF2A312C),
};

const Map<int, Color> blueSwatch = <int, Color>{
  50: Color(0xFFEEF8FE),
  100: Color(0xFFE2F4FD),
  200: Color(0xFFD4EEFC),
  300: Color(0xFFC6E9FB),
  400: Color(0xFFA9DEF9),
  500: Color(0xFF8DB9CF),
  600: Color(0xFF7194A6),
  700: Color(0xFF546F7C),
  800: Color(0xFF384A53),
  900: Color(0xFF222C32),
};

const Map<int, Color> purpleSwatch = <int, Color>{
  50: Color(0xFFFAF3FE),
  100: Color(0xFFF6EAFD),
  200: Color(0xFFEDD6FB),
  300: Color(0xFFE4C1F9),
  400: Color(0xFF9881A6),
  500: Color(0xFF4C4053),
  600: Color(0xFF1E1E1E),
};

const Map<int, Color> whiteSwatch = <int, Color>{
  50: Color(0xFFFAFAFA),
  100: Color(0xFFF6F6F6),
  200: Color(0xFFF1F1F1),
  300: Color(0xFFE9E9E9),
  400: Color(0xFFE4E4E4),
  500: Color(0xFFBEBEBE),
  600: Color(0xFF989898),
  700: Color(0xFF727272),
  800: Color(0xFF4C4C4C),
  900: Color(0xFF2E2E2E),
};

const MaterialColor pink = MaterialColor(0xFFFF99CB, pinkSwatch);
const MaterialColor yellow =  MaterialColor(0xFFFCF6BD, yellowSwatch);
const MaterialColor green =  MaterialColor(0xFFD0F4DE, greenSwatch);
const MaterialColor blue = MaterialColor(0xFFA9DEF9, blueSwatch);
const MaterialColor purple = MaterialColor(0xFFE4C1F9, purpleSwatch);
const MaterialColor white = MaterialColor(0xFFE4E4E4, whiteSwatch);
