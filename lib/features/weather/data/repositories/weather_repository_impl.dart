import 'dart:convert';

import 'package:weather_app/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;

class WeatherRepositoryImpl implements WeatherRepository {
  static const String _apiKey = '29cbd8a1f3a734b841f5a3d9ed688744';

  final WeatherLocalDataSourceImpl localDataSourceImpl;

  WeatherRepositoryImpl({required this.localDataSourceImpl});

  @override
  Future<WeatherModel> getWeatherWithLocation(String city, String units) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=$units';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  @override
  Future<void> saveLocation(String city) async {
    await localDataSourceImpl.saveLocation(city);
  }

  @override
  Future<String> getLocation() async {
    return await localDataSourceImpl.getLocation();
  }

  @override
  Future<String> getUnits() async {
    return await localDataSourceImpl.getUnits();
  }

  @override
  Future<void> saveUnits(String units) async {
    await localDataSourceImpl.saveUnits(units);
  }
}
