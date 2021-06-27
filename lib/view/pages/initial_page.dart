import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/view/pages/login_page.dart';
import 'package:weather_auth_app_with_bloc/view/pages/weather_page.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/user_view_model.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.put(AuthController());

    return Obx(() {
      User? user = _authController.user;
      print(user == null ? "null user" : user.email! + "aaaaaaaaaaaaaaaaaaaaa");
      if (user == null) {
        print(
            user == null ? "null user" : user.email! + "aaaaaaaaaaaaaaaaaaaaa");
        return LoginPage();
      } else {
        print(
            user == null ? "null user" : user.email! + "aaaaaaaaaaaaaaaaaaaaa");
        return WeatherPage();
      }
    });
  }
}
