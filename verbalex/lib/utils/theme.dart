import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color.fromARGB(255, 13, 71, 161),
  focusColor: const Color.fromARGB(255, 239, 83, 80),
  canvasColor: const Color.fromARGB(255, 231, 234, 239),
  fontFamily: GoogleFonts.lato().fontFamily,
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
    iconColor: MaterialStateProperty.all<Color>(Colors.black),
  )),
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: Colors.transparent,
        decorationColor: Colors.black,
        // This shadow configuration is to configure the amount of spacing 
        // between the underline and the text.
        shadows: [Shadow(color: Colors.black, offset: Offset(0, -5))]
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w600, 
        fontSize: 20, 
        color: Colors.black
      ),
      displaySmall: TextStyle(
        color: Colors.black,
        fontSize: 16
      ),
      bodySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: Color.fromARGB(255, 58, 80, 107))),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(255, 13, 71, 161),
  focusColor: const Color.fromARGB(255, 239, 83, 80),
  canvasColor: const Color.fromARGB(31, 255, 255, 255),
  fontFamily: GoogleFonts.lato().fontFamily,
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
    iconColor: MaterialStateProperty.all<Color>(Colors.white),
  )),
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: Colors.transparent,
        decorationColor: Colors.white,
        // This shadow configuration is to configure the amount of spacing 
        // between the underline and the text.
        shadows: [Shadow(color: Colors.white, offset: Offset(0, -5))]
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w600, 
        fontSize: 20, 
        color: Colors.white
      ),
      displaySmall: TextStyle(
        color: Colors.white,
        fontSize: 16
      ),
      bodySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: Color.fromARGB(255, 255, 255, 255)
      ),
  ),
);
