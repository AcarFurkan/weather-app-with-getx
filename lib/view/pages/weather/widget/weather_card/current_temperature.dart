import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/weather.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/weather_viewmodel.dart';

class CurrentTemperature extends StatelessWidget {
  int index;

  CurrentTemperature({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherViewModel _weatherViewModel = Get.find();
    Weather _weather = _weatherViewModel.weather;
    ConsolidatedWeather _consolidatedWeather =
        _weather.consolidatedWeather![index];
    return Text(
      _consolidatedWeather.theTemp!.toInt().toString() + " ℃",
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
