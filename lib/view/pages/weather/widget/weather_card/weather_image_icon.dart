import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/weather.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/weather_viewmodel.dart';

class WeatherImageIcon extends StatelessWidget {
  int index;

  WeatherImageIcon({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherViewModel _weatherViewModel = Get.find();
    Weather _weather = _weatherViewModel.weather;
    ConsolidatedWeather _consolidatedWeather =
        _weather.consolidatedWeather![index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: 150,
        child: Image.network(
            "https://www.metaweather.com/static/img/weather/png/" +
                _consolidatedWeather.weatherStateAbbr! +
                ".png"),
      ),
    );
  }
}
