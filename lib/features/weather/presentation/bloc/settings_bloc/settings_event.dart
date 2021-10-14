abstract class SettingsEvent {}

class SaveLocationEvent extends SettingsEvent {
  final String city;

  SaveLocationEvent({required this.city});
}

class SaveUnitsEvent extends SettingsEvent {
  final String units;

  SaveUnitsEvent({required this.units});
}
