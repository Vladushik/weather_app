import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:weather_app/features/weather/presentation/bloc/settings_bloc/settings_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/settings_bloc/settings_event.dart';
import '../../../../injection_container.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (_) => sl<SettingsBloc>(),
      child: SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final controller = TextEditingController();

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a city',
              ),
              controller: controller,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  settingsBloc.add(SaveLocationEvent(city: controller.text));
                  controller.clear();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurple[100]),
                ),
                child: const Text(
                  'Save city',
                ),
              ),
            ),
            Row(
              children: [
                Text('Temperature units'),
                Spacer(),
                DropDownWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DropDownWidget extends StatefulWidget {
  DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String dropdownValue = 'metric';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> _getUnits() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('units') ?? 'metric';
  }

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return FutureBuilder(
      future: _getUnits(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return DropdownButton<String>(
          value: snapshot.data,
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              settingsBloc.add(SaveUnitsEvent(units: dropdownValue));
            });
          },
          items: <String>['metric', 'imperial']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
      },
    );
  }
}
