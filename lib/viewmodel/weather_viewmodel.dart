import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/weather.dart';
import 'package:weather_auth_app_with_bloc/repository/weather_repository.dart';
import 'package:weather_auth_app_with_bloc/utils/locator/locator.dart';

enum WeatherState {
  weatherLoaded,
  weatherLoading,
  weatherLoadingError,
  weatherInitial,
  weatherRefresh
}

class WeatherViewModel extends GetxController {
  late Weather weather;
  WeatherRepository _weatherRepository = getIt<WeatherRepository>();

  Rx<WeatherState> _weatherState = Rx(WeatherState.weatherInitial);

  WeatherState get weatherState => _weatherState.value;

  set weatherState(WeatherState value) {
    print(value);
    _weatherState.value = value;
  }

  Future<Weather?> fetchWeather(String cityName) async {
    Weather? weather;
    weatherState = WeatherState.weatherLoading;

    try {
      weather = await _weatherRepository.fetchWeather(cityName);
      print(weather.consolidatedWeather![0].weatherStateName);
      weatherState = WeatherState.weatherLoaded;
      this.weather = weather;
      print(1);
    } catch (e) {
      weatherState = WeatherState.weatherLoadingError;
      print(e);
    }
    return weather;
  }

  Future<Weather?> updateWeather(String cityName) async {
    Weather? weather;
    weatherState = WeatherState.weatherRefresh;
    try {
      weather = await _weatherRepository.fetchWeather(cityName);
      print(weather.consolidatedWeather![0].weatherStateName);
      weatherState = WeatherState.weatherLoaded;
      this.weather = weather;
      print(1);
    } catch (e) {
      weatherState = WeatherState.weatherLoadingError;
      print(e);
    }
    return weather;
  }

  String? fetchWeatherAbbreviation() {
    return weather.consolidatedWeather![0].weatherStateAbbr;
  }
}
