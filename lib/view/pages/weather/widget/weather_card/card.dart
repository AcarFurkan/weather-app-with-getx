import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/my_theme.dart';
import 'package:weather_auth_app_with_bloc/model/weather.dart';
import 'package:weather_auth_app_with_bloc/utils/extensions/context_extension.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/theme_view_model.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/weather_viewmodel.dart';

import 'current_temperature.dart';
import 'last_update.dart';
import 'max_min_temperature.dart';
import 'title.dart';
import 'weather_image_icon.dart';

class WeatherCard extends StatelessWidget {
  int index;
  WeatherCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherViewModel _weatherViewModel = Get.find();
    Weather _weather = _weatherViewModel.weather;
    ConsolidatedWeather _consolidatedWeather =
        _weather.consolidatedWeather![index];

    ThemeViewModel _themeViewModel = Get.find();
    _themeViewModel.changeTheme(_consolidatedWeather.weatherStateAbbr!);

    MyTheme myTheme = _themeViewModel.myTheme;
    MaterialColor color = myTheme.color;

    return Center(
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          height: context.ultraHighValueHeight * 3,
          width: context.ultraHighValueWidth * 3.3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color[700]!, color[500]!, color[200]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.6, 0.8, 1]),
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(height: context.normalValueHeight),
              const WeatherCardTitle(),
              SizedBox(height: context.lowValueHeight),
              LastUpdate(index: index),
              SizedBox(height: context.lowValueHeight),
              CurrentTemperature(index: index),
              WeatherImageIcon(index: index),
              MaxMinTemperature(index: index),
            ],
          ),
        ),
      ),
    );
  }
}
