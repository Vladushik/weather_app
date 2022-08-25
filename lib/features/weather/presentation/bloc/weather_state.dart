import 'package:weather_app/features/weather/data/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  WeatherModel weatherModel;
  WeatherLoadedState({required this.weatherModel});
}

class WeatherErrorState extends WeatherState {
  String error;

  WeatherErrorState(this.error);
}
