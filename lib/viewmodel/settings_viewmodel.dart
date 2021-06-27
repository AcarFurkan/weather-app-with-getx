import 'package:get/get.dart';

import 'auth_viewmodel.dart';
import 'weather_viewmodel.dart';

class SettingsViewModel extends GetxController {
  WeatherViewModel _weatherViewModel = Get.find();
  UserAuthViewModel _userAuthViewModel = Get.find();
  Future signOut() async {
    _weatherViewModel.weatherState = WeatherState.weatherInitial;
    await _userAuthViewModel.signOut();
  }
}
