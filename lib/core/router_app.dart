import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/pages/search_page.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';

class RouterApp {
  static const String searchPage = "searchPage";
  static const String weatherPage = "/";

  static Route<dynamic> onGenerateRoute(settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case weatherPage:
        return MaterialPageRoute(builder: (context) => const WeatherPage());
      case searchPage:
        return MaterialPageRoute(builder: (context) => const SearchPage());
      default:
        throw 'Undefined route: "${settings.name}"';
    }
  }
}
