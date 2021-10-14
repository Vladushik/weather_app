import 'package:weather_app/features/weather/data/models/weather_model.dart';

abstract class WeatherState {}

class WeatherEmptyState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  WeatherModel weather;

  WeatherLoadedState({required this.weather});
}

class WeatherErrorState extends WeatherState {}
