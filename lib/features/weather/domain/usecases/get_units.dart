import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetUnits {
  final WeatherRepository repository;

  GetUnits(this.repository);

  Future<String> call() async {
    return await repository.getUnits();
  }
}
