import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Colors/colors.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: blackColor,
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: primaryColor,
    ),
    headlineLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: secondaryColor,
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: secondaryColor,

  ),
  iconTheme:  IconThemeData(size: 35, color: blackColor),

);

ThemeData lightTheme  = ThemeData(
  brightness: Brightness.light,
  primaryColor: secondaryColor,
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: primaryColor,
    ),
    headlineLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: blackColor,
    ),
  ),
  iconTheme:  IconThemeData(size: 35, color: blackColor),


);
