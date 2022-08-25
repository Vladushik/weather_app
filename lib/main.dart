import 'package:flutter/material.dart';
import 'package:weather_app/core/injection_container.dart' as di;
import 'package:weather_app/core/resources/app_themes.dart';
import 'package:weather_app/core/router_app.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WeatherPage(),
      debugShowCheckedModeBanner: false,
      title: 'WeatherPro',
      themeMode: ThemeMode.system,
      theme: ThemesApp.lightTheme,
      darkTheme: ThemesApp.darkTheme,
      initialRoute: RouterApp.weatherPage,
      onGenerateRoute: RouterApp.onGenerateRoute,
    );
  }
}
