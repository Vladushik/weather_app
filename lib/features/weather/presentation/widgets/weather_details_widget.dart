import 'package:flutter/material.dart';

import 'package:weather_app/core/resources/app_resources.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

class WeatherDetailsWidget extends StatelessWidget {
  const WeatherDetailsWidget(this.weatherModel, {Key? key}) : super(key: key);

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    var windSpeed = '${weatherModel.current!.windKph} k/h';
    var humidity = '${weatherModel.current!.humidity}';
    var pressure = '${weatherModel.current!.pressureMb!.round().toInt()}';
    var feelsLike = '${weatherModel.current!.feelslikeC}°';
    return Container(
      decoration: BoxDecoration(
        color: ColorsApp.backContainerColor,
        borderRadius: BorderRadius.circular(ConstApp.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(ConstApp.mPadding),
            child: Text(StringsApp.details),
          ),
          const HorizontalDividerWidget(),
          IntrinsicHeight(
            child: Row(
              children: [
                DetailWidget(
                  value: windSpeed,
                  name: StringsApp.windSpeed,
                  icon: const Icon(Icons.wind_power),
                ),
                const VerticalDividerWidget(),
                DetailWidget(
                  value: humidity,
                  name: StringsApp.humidity,
                  icon: const Icon(Icons.percent),
                ),
              ],
            ),
          ),
          const HorizontalDividerWidget(),
          IntrinsicHeight(
            child: Row(
              children: [
                DetailWidget(
                  value: pressure,
                  name: StringsApp.pressure,
                  icon: const Icon(Icons.speed),
                ),
                const VerticalDividerWidget(),
                DetailWidget(
                  value: feelsLike,
                  name: StringsApp.feelsLike,
                  icon: const Icon(Icons.accessibility),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    Key? key,
    required this.value,
    required this.name,
    required this.icon,
  }) : super(key: key);

  final String value;
  final String name;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: ConstApp.sHeight,
          horizontal: ConstApp.lHeight,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(value),
              ],
            ),
            icon,
          ],
        ),
      ),
    );
  }
}

class HorizontalDividerWidget extends StatelessWidget {
  const HorizontalDividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0,
      thickness: 1,
      color: Colors.white,
    );
  }
}

class VerticalDividerWidget extends StatelessWidget {
  const VerticalDividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      width: 0,
      thickness: 1,
      color: Colors.white,
    );
  }
}
