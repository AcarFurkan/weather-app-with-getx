//import 'dart:convert' as convert;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_auth_app_with_bloc/model/weather.dart';

class WeatherService {
  String secondUrl = "https://www.metaweather.com/api/location/44418/";
  String baseUrl = "https://www.metaweather.com/";

  final http.Client httpClient = http.Client();
  Future<int> fetchCityInfo(String cityName) async {
    String url = baseUrl + "api/location/search/?query=" + cityName;
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;
      return jsonResponse[0]["woeid"];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw (" fetch city info http response hata !!");
    }
  }

  Future<Weather> fetchWeather(int woeid) async {
    String url = baseUrl + "api/location/" + woeid.toString() + "/";
    print(url);
    var response = await httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = await (jsonDecode(response.body));
      return Weather.fromJson(jsonResponse);
    } else {
      throw ("fetch weather http response hata!!!");
    }
  }
}
