import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static String get mainFont => 'Quicksand';
  static Color get greyContainerColor => Color(0xffe5e7ea);
  static Color get blueGreyHoverColor => Color(0xffb5b9c6);
  static Color get darkBorder => Color(0xff183153);
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      textTheme: ThemeData.light().textTheme.copyWith(
        bodyLarge: GoogleFonts.getFont(
          mainFont,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        bodyMedium: GoogleFonts.getFont(
          mainFont,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        bodySmall: GoogleFonts.getFont(mainFont, fontSize: 13),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
          side: BorderSide(color: AppTheme.darkBorder, width: 2),
        ),
        textStyle: GoogleFonts.getFont(
          mainFont,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsetsGeometry.all(20)),
          backgroundColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return AppTheme.blueGreyHoverColor;
            }
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey;
            }
            return Colors.white;
          }),
          foregroundColor: WidgetStatePropertyAll(AppTheme.darkBorder),
          side: WidgetStatePropertyAll(BorderSide(color: darkBorder, width: 2)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.getFont(
              mainFont,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
