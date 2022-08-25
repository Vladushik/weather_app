import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/injection_container.dart';
import 'package:weather_app/core/resources/app_resources.dart';
import 'package:weather_app/features/weather/presentation/pages/search_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/widgets.dart';
import 'package:weather_app/features/weather/presentation/bloc/bloc.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WeatherBloc>()..add(WeatherLoadByCityEvent()),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              BlocProvider.of<WeatherBloc>(context).add(
                WeatherLoadByPositionEvent(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              String? city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
              if (city != null && city != '') {
                BlocProvider.of<WeatherBloc>(context)
                    .add(WeatherLoadByCityEvent(city: city));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is WeatherLoadingState) {
              return const CircularProgressIndicator(
                color: ColorsApp.whiteColor,
              );
            }
            if (state is WeatherLoadedState) {
              return WeatherLoadedWidget(state.weatherModel);
            }
            if (state is WeatherErrorState) {
              return Text(state.error);
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class WeatherLoadedWidget extends StatelessWidget {
  const WeatherLoadedWidget(this.weather, {Key? key}) : super(key: key);
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<WeatherBloc>().add(WeatherLoadByCityEvent());
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ConstApp.mPadding),
          child: Column(
            children: [
              WeatherCurrentWidget(weather),
              const SizedBox(height: ConstApp.lHeight),
              WeatherDetailsWidget(weather),
              const SizedBox(height: ConstApp.lHeight),
              WeatherListDayWidget(weather),
              const SizedBox(height: ConstApp.lHeight),
              WeatherListWeekWidget(weather),
            ],
          ),
        ),
      ),
    );
  }
}
