import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<void> saveUnits(String units);
  Future<void> saveLocation(String city);

  Future<String> getLocation();
  Future<String> getUnits();
}

const currentCity = 'London';
const currentUnits = 'metric';

class WeatherLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String> getLocation() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('city') ?? currentCity;
  }

  @override
  Future<void> saveLocation(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', city);
  }

  @override
  Future<String> getUnits() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('units') ?? currentUnits;
  }

  @override
  Future<void> saveUnits(String units) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('units', units);
  }
}
