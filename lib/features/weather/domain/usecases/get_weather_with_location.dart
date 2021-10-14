import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherWithLocation {
  final WeatherRepository repository;

  GetWeatherWithLocation(this.repository);

  Future<WeatherModel> call(String city, String units) async {
    return await repository.getWeatherWithLocation(city, units);
  }
}
