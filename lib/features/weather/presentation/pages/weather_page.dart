import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/util/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc/weather_state.dart';

import '../../../../injection_container.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (_) => sl<WeatherBloc>(),
      child: WeatherForm(),
    );
  }
}

class WeatherForm extends StatelessWidget {
  const WeatherForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: Image.asset(
                'assets/images/signup_top.png',
                width: 30.w,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/login_bottom.png',
                width: 30.w,
              ),
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherEmptyState) {
                  return LoadingIndicator();
                }
                if (state is WeatherLoadedState) {
                  return SafeArea(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.weather.name,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: kTextColor,
                            ),
                          ),
                          Text(
                            '${state.weather.temp.toStringAsFixed(0)}'
                            '°',
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 60.sp,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 1.h,
                                horizontal: 2.w,
                              ),
                              color: kGreyColor,
                              child: Text(
                                state.weather.description,
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const FaIcon(FontAwesomeIcons.tint),
                                    SizedBox(width: 2.w),
                                    Text('${state.weather.humidity}' '%'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const FaIcon(
                                        FontAwesomeIcons.arrowCircleDown),
                                    SizedBox(width: 2.w),
                                    Text(state.weather.pressure),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const FaIcon(FontAwesomeIcons.wind),
                                    SizedBox(width: 2.w),
                                    Text(state.weather.windSpeed),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Today',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10, //state.loadedCrypt.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 25.w,
                                  height: 15.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('10 AM'),
                                      FaIcon(FontAwesomeIcons.cloud),
                                      Text(
                                        '19°',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 4.h),
                          SizedBox(
                            height: 20.h,
                            child: ListView.builder(
                              itemCount: 5, //state.loadedCrypt.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 25.w,
                                  height: 7.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Expanded(child: Text('Tuesday')),
                                      const Expanded(
                                          child:
                                              FaIcon(FontAwesomeIcons.cloud)),
                                      Row(
                                        children: [
                                          Text(
                                            '19°',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          Text(
                                            '19°',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
