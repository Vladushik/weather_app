import 'package:dio/dio.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather({city = '', lat = '', lon = ''});
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  static const String apiKey = '58efada73514428387d70946221007';

  @override
  Future<WeatherModel> getWeather({city = '', lat = '', lon = ''}) async {
    String url =
        "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city$lat,$lon&days=7";
    try {
      Response response = await Dio().get(url);
      if (response.statusCode == 200) {
        WeatherModel data = WeatherModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to load weather');
      }
    } on DioError catch (e) {
      print(e.message);
      throw e.message;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
