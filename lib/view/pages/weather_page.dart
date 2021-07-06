import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/view/pages/weather/page/weather_initial_page.dart';
import 'package:weather_auth_app_with_bloc/view/pages/weather/page/weather_loading_error_page.dart';
import 'package:weather_auth_app_with_bloc/view/pages/weather/page/weather_loading_page.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/weather_viewmodel.dart';

import 'weather/page/weather_loaded_page.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => buildScaffold());
  }

  Widget buildScaffold() {
    WeatherViewModel _weatherViewModel = Get.put(WeatherViewModel());
    var weatherState = _weatherViewModel.weatherState;

    switch (weatherState) {
      case WeatherState.weatherInitial:
        return WeatherInitialPage();

      case WeatherState.weatherLoaded:
        return WeatherLoaded();

      case WeatherState.weatherRefresh:
        return WeatherLoaded();

      case WeatherState.weatherLoading:
        return WeatherLoadingPage();

      case WeatherState.weatherLoadingError:
        return WeatherLoadingErrorPage();
    }
  }
}
