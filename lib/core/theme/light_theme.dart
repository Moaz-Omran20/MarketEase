import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'light_colors.dart';

ThemeData lightTheme = ThemeData(
  snackBarTheme: SnackBarThemeData(contentTextStyle: TextStyle(color: Colors.white)),
  primaryColor: LightColors.primaryColor,
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: LightColors.backgroundColor,
    onPrimary: LightColors.primaryColor,
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xFF3A4640),
  ),
  scaffoldBackgroundColor: LightColors.backgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: LightColors.backgroundColor,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    centerTitle: false,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  // switchTheme: SwitchThemeData(
  //   trackColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Color(0xFF15B86C);
  //     }
  //     return Colors.white;
  //   }),
  //   thumbColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Colors.white;
  //     }
  //     return Color(0xFF9E9E9E);
  //   }),
  //   trackOutlineColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Colors.transparent;
  //     }
  //     return Color(0xFF9E9E9E);
  //   }),
  //   trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return 0;
  //     }
  //     return 2;
  //   }),
  // ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      backgroundColor: WidgetStateProperty.all(LightColors.primaryColor),
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(LightColors.primaryColor),
    ),
  ),
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: Color(0xFF15B86C),
  //   foregroundColor: Color(0xFFFFFCFC),
  //   extendedTextStyle: TextStyle(
  //     fontSize: 14,
  //     fontWeight: FontWeight.w500,
  //   ),
  // ),
  textTheme: TextTheme(
    displaySmall: GoogleFonts.roboto(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    // displayMedium: GoogleFonts.roboto(
    //   fontSize: 28,
    //   color: Color(0xFF161F1B),
    //   fontWeight: FontWeight.w400,
    // ),
    displayLarge: GoogleFonts.roboto(
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: GoogleFonts.roboto(
      color: Color(0xFF3A4640),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: GoogleFonts.roboto(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: GoogleFonts.roboto(
      color: Colors.white,
      fontSize: 24,
      // decoration: TextDecoration.lineThrough,
      // decorationColor: Color(0xFF49454F),
      fontWeight: FontWeight.w400,
    ),
    // labelSmall: GoogleFonts.roboto(
    //   fontWeight: FontWeight.w400,
    //   color: Color(0xFF161F1B),
    //   fontSize: 20,
    // ),
    labelMedium: GoogleFonts.roboto(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    // labelLarge: GoogleFonts.roboto(color: Colors.black, fontSize: 24),
    bodyMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      color: Color(0xFF6E7191),
      fontSize: 16,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Color(0xFF9E9E9E)),
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    filled: true,
    activeIndicatorBorder: BorderSide(color: LightColors.primaryColor),
    iconColor: LightColors.primaryColor,
    suffixIconColor: LightColors.primaryColor,
    fillColor: Color(0xFF150B2E),
    focusColor: Color(0xFFD1DAD6),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent, width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent, width: 0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent, width: 0.5),
    ),
  ),
  // checkboxTheme: CheckboxThemeData(
  //   side: BorderSide(
  //     color: Color(0xFFD1DAD6),
  //     width: 2,
  //   ),
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(4),
  //   ),
  // ),
  iconTheme: IconThemeData(color: Color(0xFF161F1B)),

  // listTileTheme: ListTileThemeData(
  //   titleTextStyle: TextStyle(
  //     color: Color(0xFF161F1B),
  //     fontSize: 16,
  //     fontWeight: FontWeight.w400,
  //   ),
  // ),
  // dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6)),
  // textSelectionTheme: TextSelectionThemeData(
  //   cursorColor: Colors.black,
  //   selectionColor: Colors.white,
  //   selectionHandleColor: Colors.black,
  // ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightColors.backgroundColor,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.white,
    selectedIconTheme: IconThemeData(color: LightColors.primaryColor),
    selectedItemColor: LightColors.primaryColor,
    showSelectedLabels: true,
  ),

  splashFactory: NoSplash.splashFactory,
  // popupMenuTheme: PopupMenuThemeData(
  //   color: Color(0xFFF6F7F9),
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(16),
  //   ),
  //   elevation: 2,
  //   shadowColor: Color(0xFF15B86C),
  //   labelTextStyle: WidgetStateProperty.all(
  //     TextStyle(
  //       fontSize: 20,
  //       fontWeight: FontWeight.w400,
  //       color: Colors.black,
  //     ),
  //   ),
  // ),
);
