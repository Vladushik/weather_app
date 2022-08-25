import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/utils/geolocator.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import '../features/weather/data/repositories/weather_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => WeatherBloc(weatherRepImpl: sl()));
  //Repository
  sl.registerLazySingleton(() => WeatherRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
      ));
  //Utils
  sl.registerLazySingleton(() => GeolocatorApp());
  //DataSources
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton(() => WeatherRemoteDataSourceImpl());
  sl.registerLazySingleton(
      () => WeatherLocalDataSourceImpl(sharedPreferences: sl()));
  //Shared
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
