import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/view/pages/weather_page.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/auth_viewmodel.dart';

import 'login_page.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //AuthController _authController = Get.put(AuthController());
    //var authProvider = context.watch<UserAuthViewModel>();
    Get.put(UserAuthViewModel());

    //User? user = _authController.user;

    //UserState userState = _userAuthViewModel.userState;
    return Obx(() {
      UserAuthViewModel _userAuthViewModel = Get.find();
      UserState userState = _userAuthViewModel.userState;
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      if (userState == UserState.loggedIn) {
        print("WEATHER PAGE");
        return WeatherPage();
      } else if (userState == UserState.logging) {
        print("LOGGİNG PAGE");

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (userState == UserState.loginError) {
        print("LOGİN ERROR PAGE");

        return const Center(
          child: Text("Error"),
        );
      } else {
        print("NOT LOGIN PAGE");

        return LoginPage();
      }
    });
  }
}

/*
* class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.put(AuthController());

    //var authProvider = context.watch<UserAuthViewModel>();
    return Obx(() {
      User? user = _authController.user;
      print(user == null ? "null user" : user.email! + "aaaaaaaaaaaaaaaaaaaaa");
      if (user == null) {
        print(
            user == null ? "null user" : user.email! + "aaaaaaaaaaaaaaaaaaaaa");
        return LoginPage();
      } else {
        print(user.email! + "aaaaaaaaaaaaaaaaaaaaa");
        return WeatherPage();
      }
    });
  }
}*/
