import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/repository/user_repository.dart';
import 'package:weather_auth_app_with_bloc/utils/locator/locator.dart';

import 'weather_viewmodel.dart';

class SettingsViewModel extends GetxController {
  UserRepository _userRepository = getIt<UserRepository>();
  WeatherViewModel _weatherViewModel = Get.find();
  Future signOut() async {
    _weatherViewModel.weatherState = WeatherState.weatherInitial;
    await _userRepository.signOut();
  }
}
