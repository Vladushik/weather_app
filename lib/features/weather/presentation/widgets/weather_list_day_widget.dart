import 'package:flutter/material.dart';
import 'package:weather_app/core/resources/app_resources.dart';
import 'package:weather_app/core/utils/date_time_format.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

class WeatherListDayWidget extends StatelessWidget {
  const WeatherListDayWidget(this.weatherModel, {Key? key}) : super(key: key);

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    var itemCount = weatherModel.forecast!.forecastday![0].hour!.length;
    return Container(
      decoration: BoxDecoration(
        color: ColorsApp.backContainerColor,
        borderRadius: BorderRadius.circular(ConstApp.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(ConstApp.mPadding),
            child: const Text(StringsApp.today),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: ConstApp.mPadding,
              right: ConstApp.mPadding,
              bottom: ConstApp.mPadding,
            ),
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) {
                String temp =
                    '${weatherModel.forecast?.forecastday?[0].hour?[index].tempC?.round()}°';
                DateTime time =
                    weatherModel.forecast!.forecastday![0].hour![index].time!;
                String image =
                    'https:${weatherModel.forecast!.forecastday![0].hour![index].condition!.icon}';

                if (time.isAfter(DateTime.now()) ||
                    time.hour == (DateTime.now().hour)) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: ConstApp.mPadding,
                    ),
                    margin: const EdgeInsets.only(
                      right: ConstApp.mPadding,
                    ),
                    width: 80,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(ConstApp.borderRadius),
                      ),
                      color: ColorsApp.smallContainerColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          temp,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Image.network(
                          image,
                          errorBuilder: (context, exception, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                        Text(
                          DateTimeFormat.formatTime(time),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
