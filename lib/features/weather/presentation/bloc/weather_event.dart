abstract class WeatherEvent {}

class WeatherLoadByPositionEvent extends WeatherEvent {}

class WeatherLoadByCityEvent extends WeatherEvent {
  final String city;

  WeatherLoadByCityEvent({this.city = ''});
}
