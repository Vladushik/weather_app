import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetLocation {
  final WeatherRepository repository;

  GetLocation(this.repository);

  Future<String> call() async {
    return await repository.getLocation();
  }
}
