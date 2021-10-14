class WeatherModel {
  final String name;
  final double temp;
  final String iconCode;
  final String description;
  final DateTime time;
  final String windSpeed;
  final String country;
  final String pressure;
  final String humidity;
  final String minTemp;
  final String maxTemp;

  WeatherModel({
    required this.name,
    required this.temp,
    required this.iconCode,
    required this.description,
    required this.time,
    required this.windSpeed,
    required this.country,
    required this.pressure,
    required this.humidity,
    required this.minTemp,
    required this.maxTemp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      name: json['name'].toString(),
      temp: json['main']['temp'],
      iconCode: json['weather'][0]['icon'].toString(),
      description: json['weather'][0]['main'].toString(),
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      windSpeed: json['wind']['speed'].toString(),
      pressure: json['main']['pressure'].toString(),
      country: json['sys']['country'].toString(),
      humidity: json['main']['humidity'].toString(),
      maxTemp: json['main']['temp_max'].toString(),
      minTemp: json['main']['temp_min'].toString(),
    );
  }
}
