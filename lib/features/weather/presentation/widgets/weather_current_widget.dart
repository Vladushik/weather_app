import 'package:flutter/material.dart';
import 'package:weather_app/core/resources/app_resources.dart';
import 'package:weather_app/core/utils/date_time_format.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

class WeatherCurrentWidget extends StatelessWidget {
  const WeatherCurrentWidget(this.weatherModel, {Key? key}) : super(key: key);

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    String city = weatherModel.location!.name!;
    String country = weatherModel.location!.country!;
    String tempC = '${weatherModel.current!.tempC!.round().toInt()}°';
    int temp = weatherModel.current!.tempC!.round().toInt();
    String desc = weatherModel.current!.condition!.text!;
    String image = 'https:${weatherModel.current!.condition!.icon!}';
    DateTime lastUpdated = weatherModel.current!.lastUpdated!;
    String lastUpdate = DateTimeFormat.formatDateMDHM(lastUpdated);

    return Container(
      padding: const EdgeInsets.all(ConstApp.mPadding),
      decoration: BoxDecoration(
        color: ColorsApp.backContainerColor,
        borderRadius: BorderRadius.circular(ConstApp.borderRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(city, style: const TextStyle(fontSize: 28)),
                    Text(country, style: const TextStyle(fontSize: 18)),
                    Text(
                      tempC,
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(ConstApp.mPadding),
                      decoration: BoxDecoration(
                        color: ColorsApp.smallContainerColor,
                        borderRadius: BorderRadius.circular(
                          ConstApp.borderRadius,
                        ),
                      ),
                      child: Text(desc),
                    ),
                    const SizedBox(height: ConstApp.mHeight),
                    Container(
                      padding: const EdgeInsets.all(ConstApp.mPadding),
                      decoration: BoxDecoration(
                        color: ColorsApp.smallContainerColor,
                        borderRadius: BorderRadius.circular(
                          ConstApp.borderRadius,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(StringsApp.lastUpdate),
                          Text(lastUpdate),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Image.network(
                    image,
                    errorBuilder: (context, exception, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
