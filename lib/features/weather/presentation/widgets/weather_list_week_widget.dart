import 'package:flutter/material.dart';
import 'package:weather_app/core/resources/app_resources.dart';
import 'package:weather_app/core/utils/date_time_format.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

class WeatherListWeekWidget extends StatelessWidget {
  const WeatherListWeekWidget(this.weatherModel, {Key? key}) : super(key: key);

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    var itemCount = weatherModel.forecast!.forecastday!.length;
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
            child: const Text(StringsApp.week),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: ConstApp.mPadding,
              right: ConstApp.mPadding,
              bottom: ConstApp.mPadding,
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) {
                DateTime date =
                    weatherModel.forecast!.forecastday![index].date!;
                double maxTemp =
                    weatherModel.forecast!.forecastday![index].day!.maxtempC!;
                String desc = weatherModel
                    .forecast!.forecastday![index].day!.condition!.text!;
                String maxTempC =
                    '${weatherModel.forecast?.forecastday?[index].day?.maxtempC?.round()}°';
                String minTempC =
                    '${weatherModel.forecast?.forecastday?[index].day?.mintempC?.round()}°';

                String image =
                    'https:${weatherModel.forecast!.forecastday![index].day!.condition!.icon!}';
                return Container(
                  height: 50,
                  width: 70,
                  padding: const EdgeInsets.all(ConstApp.mPadding),
                  margin: const EdgeInsets.only(bottom: ConstApp.mPadding),
                  decoration: const BoxDecoration(
                    color: ColorsApp.smallContainerColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(ConstApp.borderRadius),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(DateTimeFormat.formatDate(date)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          image,
                          errorBuilder: (context, exception, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(maxTempC),
                            const SizedBox(width: ConstApp.lHeight),
                            Text(minTempC),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
