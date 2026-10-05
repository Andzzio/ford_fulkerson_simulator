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
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          foregroundColor: WidgetStatePropertyAll(AppTheme.darkBorder),
          side: WidgetStatePropertyAll(
            BorderSide(color: AppTheme.darkBorder, width: 3),
          ),
          iconSize: WidgetStatePropertyAll(15),
          mouseCursor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return SystemMouseCursors.click;
            }
            return SystemMouseCursors.none;
          }),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(AppTheme.darkBorder),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.getFont(
              mainFont,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        titleTextStyle: GoogleFonts.getFont(
          mainFont,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: AppTheme.darkBorder,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppTheme.darkBorder, width: 3),
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.darkBorder, width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.darkBorder, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.darkBorder, width: 3),
        ),
      ),
      badgeTheme: BadgeThemeData(textColor: AppTheme.darkBorder),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.white,
        actionTextColor: AppTheme.darkBorder,
        disabledActionTextColor: AppTheme.darkBorder,
        contentTextStyle: GoogleFonts.getFont(
          mainFont,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: AppTheme.darkBorder,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
          side: BorderSide(color: AppTheme.darkBorder, width: 3),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
          side: BorderSide(color: AppTheme.darkBorder, width: 3),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
          side: BorderSide(color: AppTheme.darkBorder, width: 3),
        ),
      ),
    );
  }
}
