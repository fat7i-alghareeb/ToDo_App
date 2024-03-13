import 'package:flutter/material.dart';

///////////////////////////////////////////////////////////////////
const lightMainColor = Color(0xFFF5F5F5);
const lightSecondaryColor = Color(0xFFFFFFFF);
const lightThirdlyColor = Color(0xFFd2d5db);
///////////////////////////////////////////////////////////////////
const darkMainColor = Color(0xFF0F0F0F);
const darkSecondaryColor = Color(0xFFF2F2F2);
const darkThirdlyColor = Colors.grey;
///////////////////////////////////////////////////////////////////
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: "NewFont",
  appBarTheme: const AppBarTheme(
    color: lightMainColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: lightSecondaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  primaryColor: lightMainColor,
  scaffoldBackgroundColor: lightMainColor,
  colorScheme: const ColorScheme.light(
    primary: lightMainColor,
    secondary: lightSecondaryColor,
    tertiary: lightThirdlyColor,
  ),
);
ThemeData darkMode = ThemeData(
  fontFamily: "NewFont",
  appBarTheme: const AppBarTheme(
    color: darkMainColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: darkSecondaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  brightness: Brightness.dark,
  primaryColor: darkMainColor,
  scaffoldBackgroundColor: darkMainColor,
  colorScheme: const ColorScheme.dark(
    primary: darkMainColor,
    secondary: darkSecondaryColor,
    tertiary: darkThirdlyColor,
  ),
);
