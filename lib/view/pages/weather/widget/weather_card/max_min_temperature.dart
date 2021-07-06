import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/weather.dart';
import 'package:weather_auth_app_with_bloc/utils/extensions/context_extension.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/weather_viewmodel.dart';

class MaxMinTemperature extends StatelessWidget {
  int index;
  MaxMinTemperature({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WeatherViewModel _weatherViewModel = Get.find();
    Weather _weather = _weatherViewModel.weather;
    ConsolidatedWeather _consolidatedWeather =
        _weather.consolidatedWeather![index];

    return Padding(
      padding: context.paddingNormalHorizontal * 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Minumum: " +
                _consolidatedWeather.minTemp!.toInt().toString() +
                " ℃",
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          Text(
            "Maksimum: " +
                _consolidatedWeather.maxTemp!.toInt().toString() +
                " ℃",
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
