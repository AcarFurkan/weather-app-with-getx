import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/weather_viewmodel.dart';

import '../../search_page.dart';

class SearchButtonIcon extends StatelessWidget {
  SearchButtonIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherViewModel _weatherViewModel = Get.find();
    return IconButton(
      onPressed: () async {
        var selectedCity = await Get.to(SearchPage());
        print(selectedCity);
        _weatherViewModel.fetchWeather(selectedCity);
      },
      icon: Icon(Icons.search),
    );
  }
}
