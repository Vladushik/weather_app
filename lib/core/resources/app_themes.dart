import 'package:flutter/material.dart';
import 'package:weather_app/core/resources/app_resources.dart';

class ThemesApp {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsApp.backgroundColor,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
      color: ColorsApp.appBarColor,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
  );
}
