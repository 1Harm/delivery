import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CustomTheme {
  static final ThemeData lightTheme = ThemeData(
    // Customize the light theme properties
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    // ...
  );

  static final ThemeData darkTheme = ThemeData(
    // Customize the dark theme properties
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    // ...
  );

  static final ThemeData customTheme = ThemeData(
    // Customize the custom theme properties
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    backgroundColor: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.deepPurple,
    splashColor: Colors.deepOrange,
    cardColor: Colors.white,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.yellowAccent,
        textStyle: const TextStyle(color: Colors.black),
      )
    ),
    // ...
  );

}
