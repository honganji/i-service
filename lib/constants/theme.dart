import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    primarySwatch: Colors.green,
    primaryColor: Colors.green,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: customGreenSwatch,
      backgroundColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
    brightness: Brightness.light,
    textTheme: TextTheme(
      displayMedium: TextStyle(
        fontSize: 45,
        color: HexColor("#FFFCFC"),
        fontStyle: FontStyle.italic,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        color: HexColor("#F5CE00"),
        fontStyle: FontStyle.italic,
      ),
    ),
    useMaterial3: true,
  );
}

const MaterialColor customGreenSwatch = MaterialColor(
  0xFF1F9478,
  <int, Color>{
    50: Color(0xFFE4F2EF),
    100: Color(0xFFBCDFD7),
    200: Color(0xFF8FCABC),
    300: Color(0xFF62B4A1),
    400: Color(0xFF41A48C),
    500: Color(0xFF1F9478),
    600: Color(0xFF1B8C70),
    700: Color(0xFF178165),
    800: Color(0xFF12775B),
    900: Color(0xFF0A6548),
  },
);
