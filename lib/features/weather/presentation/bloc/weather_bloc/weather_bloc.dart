import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/usecases/get_location.dart';
import 'package:weather_app/features/weather/domain/usecases/get_units.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_with_location.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc/weather_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherWithLocation getWeatherWithLocation;
  final GetLocation getLocation;
  final GetUnits getUnits;
  final WeatherLocalDataSourceImpl weatherLocalDataSourceImpl;

  WeatherBloc({
    required this.getWeatherWithLocation,
    required this.weatherLocalDataSourceImpl,
    required this.getLocation,
    required this.getUnits,
  }) : super(WeatherEmptyState()) {
    add(WeatherLoadedEvent());
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherLoadedEvent) {
      //yield WeatherLoadingState();
      try {
        final WeatherModel _loadedWeather = await getWeatherWithLocation.call(
          await getLocation.call(),
          await getUnits.call(),
        );
        yield WeatherLoadedState(weather: _loadedWeather);
      } catch (_) {
        yield WeatherErrorState();
      }
    }
  }
}
