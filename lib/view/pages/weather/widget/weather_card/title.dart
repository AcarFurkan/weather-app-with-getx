import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/weather.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/weather_viewmodel.dart';

class WeatherCardTitle extends StatelessWidget {
  const WeatherCardTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherViewModel _weatherViewModel = Get.find();
    Weather _weather = _weatherViewModel.weather;
    return Text(
      _weather.title!,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    );
  }
}
