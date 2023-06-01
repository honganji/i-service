import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    primarySwatch: Colors.yellow,
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
