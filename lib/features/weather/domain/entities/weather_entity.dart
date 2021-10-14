class WeatherEntity {
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

  WeatherEntity({
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
}
