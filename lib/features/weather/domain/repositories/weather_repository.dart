import 'package:weather_app/features/weather/data/models/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeatherWithLocation(String city, String units);
  Future<void> saveLocation(String city);
  Future<String> getLocation();

  Future<void> saveUnits(String units);
  Future<String> getUnits();
}
