import 'package:flutter/material.dart';

class MyTheme {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 37, 34, 34),
      colorScheme: ColorScheme.dark());

  static final lighTheme = ThemeData(
      primaryColor: Colors.black45,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light());
}
