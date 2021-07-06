import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/view/pages/weather/widget/build_search_button_icon.dart';
import 'package:weather_auth_app_with_bloc/view/pages/weather/widget/settings_button_icon.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/auth_viewmodel.dart';

class WeatherInitialPage extends StatelessWidget {
  WeatherInitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserAuthViewModel myAuth = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(myAuth),
      body: buildBody(),
    );
  }

  Center buildBody() {
    return const Center(
      child: Text("plese search a city"),
    );
  }

  AppBar buildAppBar(UserAuthViewModel myAuth) {
    return AppBar(
      title: Text(
          " Weather -${myAuth.user == null ? "usernull" : myAuth.user!.email!.substring(0, 6)} "),
      actions: [SearchButtonIcon(), SettingsButtonIcon()],
    );
  }
}
