import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class SaveLocation {
  final WeatherRepository repository;

  SaveLocation(this.repository);

  Future<void> call(String city) async {
    return await repository.saveLocation(city);
  }
}
