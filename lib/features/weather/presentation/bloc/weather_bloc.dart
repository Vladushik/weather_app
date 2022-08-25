import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/resources/app_resources.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepositoryImpl weatherRepImpl;

  WeatherBloc({required this.weatherRepImpl}) : super(WeatherInitialState()) {
    on<WeatherLoadByCityEvent>(_weatherLoadByCityEvent);
    on<WeatherLoadByPositionEvent>(_weatherLoadByPositionEvent);
  }

  _weatherLoadByCityEvent(
      WeatherLoadByCityEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      var weather = await weatherRepImpl.getWeatherByCity(city: event.city);
      emit(WeatherLoadedState(weatherModel: weather));
    } catch (e) {
      emit(WeatherErrorState(StringsApp.wentWrong));
    }
  }

  _weatherLoadByPositionEvent(
      WeatherLoadByPositionEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      var weather = await weatherRepImpl.getWeatherByPosition();
      emit(WeatherLoadedState(weatherModel: weather));
    } catch (e) {
      emit(WeatherErrorState(StringsApp.geoWentWrong));
    }
  }
}
