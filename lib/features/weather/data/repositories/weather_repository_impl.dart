import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/utils/geolocator.dart';
import 'package:weather_app/core/utils/network_info.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherLocalDataSourceImpl localDataSource;
  final WeatherRemoteDataSourceImpl remoteDataSource;

  WeatherRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  getWeatherByCity({city = ''}) async {
    String lastCity = await localDataSource.getCityFromCache();
    if (city == '') {
      city = lastCity;
    }
    if (await NetworkInfo.checkNetwork()) {
      try {
        WeatherModel data = await remoteDataSource.getWeather(city: city);
        await localDataSource.saveCityToCache(data.location!.name!);
        await localDataSource.saveWeatherToCache(data);
        return data;
      } catch (e) {
        print(e);
      }
    }
    WeatherModel weatherFromCache = await localDataSource.getWeatherFromCache();
    return weatherFromCache;
  }

  @override
  getWeatherByPosition() async {
    var position = await GeolocatorApp.getLocation();
    if (await NetworkInfo.checkNetwork()) {
      try {
        WeatherModel data = await remoteDataSource.getWeather(
          lat: position.latitude.toString(),
          lon: position.longitude.toString(),
        );
        await localDataSource.saveCityToCache(data.location!.name!);
        await localDataSource.saveWeatherToCache(data);
        return data;
      } catch (e) {
        print(e);
      }
    }
    throw ServerException();
  }
}
