import 'package:weather_app/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_location.dart';
import 'package:weather_app/features/weather/domain/usecases/get_units.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_with_location.dart';
import 'package:weather_app/features/weather/domain/usecases/save_location.dart';
import 'package:weather_app/features/weather/domain/usecases/save_units.dart';
import 'package:weather_app/features/weather/presentation/bloc/settings_bloc/settings_bloc.dart';
import 'features/weather/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  sl.registerFactory(
    () => WeatherBloc(
      getWeatherWithLocation: sl(),
      weatherLocalDataSourceImpl: sl(),
      getLocation: sl(),
      getUnits: sl(),
    ),
  );
  sl.registerFactory(
    () => SettingsBloc(
      weatherLocalDataSourceImpl: sl(),
      saveLocation: sl(),
      saveUnits: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetWeatherWithLocation(sl()));
  sl.registerLazySingleton(() => SaveLocation(sl()));
  sl.registerLazySingleton(() => GetLocation(sl()));
  sl.registerLazySingleton(() => GetUnits(sl()));
  sl.registerLazySingleton(() => SaveUnits(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(localDataSourceImpl: sl()),
  );

  sl.registerLazySingleton<WeatherLocalDataSourceImpl>(
    () => WeatherLocalDataSourceImpl(sharedPreferences: sl()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
