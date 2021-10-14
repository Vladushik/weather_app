import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/domain/usecases/save_location.dart';
import 'package:weather_app/features/weather/domain/usecases/save_units.dart';
import 'package:weather_app/features/weather/presentation/bloc/settings_bloc/settings_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/settings_bloc/settings_state.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_data_source.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SaveLocation saveLocation;
  final SaveUnits saveUnits;

  final WeatherLocalDataSourceImpl weatherLocalDataSourceImpl;

  SettingsBloc({
    required this.weatherLocalDataSourceImpl,
    required this.saveLocation,
    required this.saveUnits,
  }) : super(SettingsInitialState());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SaveLocationEvent) {
      try {
        saveLocation(event.city);
      } catch (_) {
        yield SaveErrorState();
      }
    }
    if (event is SaveUnitsEvent) {
      try {
        saveUnits(event.units);
      } catch (_) {
        yield SaveErrorState();
      }
    }
  }
}
