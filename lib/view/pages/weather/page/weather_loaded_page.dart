import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/utils/extensions/context_extension.dart';
import 'package:weather_auth_app_with_bloc/view/pages/weather/widget/build_search_button_icon.dart';
import 'package:weather_auth_app_with_bloc/view/pages/weather/widget/settings_button_icon.dart';
import 'package:weather_auth_app_with_bloc/view/pages/weather/widget/weather_card/card.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/auth_viewmodel.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/theme_view_model.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/weather_viewmodel.dart';

import '../../refresh_indicator_test.dart';

class WeatherLoaded extends StatefulWidget {
  const WeatherLoaded({Key? key}) : super(key: key);

  @override
  _WeatherLoadedState createState() => _WeatherLoadedState();
}

class _WeatherLoadedState extends State<WeatherLoaded> {
  Completer<void> _refreshIndicator = Completer<void>();
  WeatherViewModel _weatherViewModel = Get.put(WeatherViewModel());
  ThemeViewModel _themeViewModel = Get.put(ThemeViewModel());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("init");
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var abbreviation = _weatherViewModel.fetchWeatherAbbreviation();
      _themeViewModel.changeScaffoldTheme(abbreviation!);
      //_themeViewModel.changeScaffoldColor(abbreviation);
    });
  }

  @override
  Widget build(BuildContext context) {
    _refreshIndicator.complete();
    _refreshIndicator = Completer<void>();
    String city = _weatherViewModel.weather.title!;

    UserAuthViewModel _userAuthViewModel = Get.find();
    return Obx(() {
      return Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _themeViewModel.scaffoldColor,
          ),
          child: buildScaffold(city),
        ),
      );
    });
  }

  Scaffold buildScaffold(String city) {
    UserAuthViewModel _userAuthViewModel = Get.find();

    return Scaffold(
      drawer: Drawer(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: buildAppBar(),
      body: buildPlaneIndicator(city),
    );
  }

  AppBar buildAppBar() {
    UserAuthViewModel _userAuthViewModel = Get.find();

    return AppBar(
      backgroundColor: _themeViewModel.scaffoldColor,
      title: Text(
          " Weather -${_userAuthViewModel.user == null ? "usernull" : _userAuthViewModel.user!.email!.substring(0, 6)} "),
      actions: [SearchButtonIcon(), SettingsButtonIcon()],
    );
  }

  PlaneIndicator buildPlaneIndicator(String city) {
    return PlaneIndicator(
        color: _themeViewModel.scaffoldColor,
        onRefresh: () {
          _weatherViewModel.updateWeather(city);
          return Future.delayed(const Duration(seconds: 2));
        },
        child: buildWeatherLoadedBody());
  }

  Widget buildWeatherLoadedBody() {
    PageController pageController = PageController(initialPage: 0);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: context.ultraHighValueHeight * 3.25,
            width: context.ultraHighValueWidth * 3.25,
            child: PageView(
              controller: pageController,
              children: buildPageViews(),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildPageViews() {
    List<Widget> pageViewElements = [];
    for (int i = 0; i < 6; i++) {
      if (i == 0) {
        // buildScaffoldColor(_weatherViewModel, i);
      }
      pageViewElements.add(WeatherCard(index: i));
    }
    return pageViewElements;
  }
}
