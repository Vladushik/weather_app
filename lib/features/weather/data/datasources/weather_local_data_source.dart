import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<String> getCityFromCache();
  Future<String> saveWeatherToCache(WeatherModel weather);
  Future<void> saveCityToCache(String city);
  Future<WeatherModel> getWeatherFromCache();
}

const cashedWeather = 'CACHED_WEATHER';
const cashedCity = 'CACHED_CITY';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;
  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<WeatherModel> getWeatherFromCache() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? json = pref.getString(cashedWeather);
    var map = jsonDecode(json!);
    WeatherModel weatherModel = WeatherModel.fromJson(map);
    return weatherModel;
  }

  @override
  Future<String> saveWeatherToCache(WeatherModel weather) async {
    final String jsonWeather = json.encode(weather.toJson());
    sharedPreferences.setString(cashedWeather, jsonWeather);
    return Future.value(jsonWeather);
  }

  @override
  Future<void> saveCityToCache(String city) async {
    sharedPreferences.setString(cashedCity, city);
  }

  @override
  Future<String> getCityFromCache() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(cashedCity) ?? 'London';
  }
}
