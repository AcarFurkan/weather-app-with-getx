import 'package:weather_auth_app_with_bloc/model/weather.dart';
import 'package:weather_auth_app_with_bloc/service/weather_service.dart';
import 'package:weather_auth_app_with_bloc/utils/locator/locator.dart';

class WeatherRepository {
  WeatherService _weatherService = getIt<WeatherService>();

  Future<Weather> fetchWeather(String cityName) async {
    int woeid = await _weatherService.fetchCityInfo(cityName);
    Weather weather = await _weatherService.fetchWeather(woeid);
    return weather;
  }
}
