import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class SaveUnits {
  final WeatherRepository repository;

  SaveUnits(this.repository);

  Future<void> call(String units) async {
    return await repository.saveUnits(units);
  }
}
