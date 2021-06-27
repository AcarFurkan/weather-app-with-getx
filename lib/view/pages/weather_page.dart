import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/my_theme.dart';
import 'package:weather_auth_app_with_bloc/model/weather.dart';
import 'package:weather_auth_app_with_bloc/utils/extentions/context_extension.dart';
import 'package:weather_auth_app_with_bloc/view/pages/settings_page.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/auth_viewmodel.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/theme_view_model.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/weather_viewmodel.dart';

import 'refresh_indicator_test.dart';
import 'search_page.dart';

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

    //final myAuth = Provider.of<UserAuthViewModel>(context, listen: true);
    UserAuthViewModel _userAuthViewModel = Get.find();
    return Obx(() {
      return Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _themeViewModel.scaffoldColor,
          ),
          child: Scaffold(
            drawer: Drawer(),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: _themeViewModel.scaffoldColor,
              title: Text(
                  " Weather -${_userAuthViewModel.user == null ? "usernull" : _userAuthViewModel.user!.email!.substring(0, 6)} "),
              actions: [buildSearchButton(), buildSettingsButton()],
            ),
            body: PlaneIndicator(
                color: _themeViewModel.scaffoldColor,
                onRefresh: () {
                  _weatherViewModel.updateWeather(city);
                  return Future.delayed(const Duration(seconds: 2));
                },
                child: buildWeatherLoadedBody(context)),
          ),
        ),
      );
    });
  }

  Widget buildWeatherLoadedBody(BuildContext context) {
    WeatherViewModel _weatherViewModel = Get.find();
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
              children: buildPageViews(context, _weatherViewModel),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildPageViews(
      BuildContext context, WeatherViewModel _weatherViewModel) {
    List<Widget> pageViewElements = [];
    for (int i = 0; i < 6; i++) {
      if (i == 0) {
        // buildScaffoldColor(_weatherViewModel, i);
      }
      pageViewElements.add(buildWeatherCard(context, _weatherViewModel, i));
    }
    return pageViewElements;
  }

  Center buildWeatherCard(
      BuildContext context, WeatherViewModel _weatherViewModel, int index) {
    Weather _weather = _weatherViewModel.weather;
    ConsolidatedWeather _consolidatedWeather =
        _weather.consolidatedWeather![index];
    ThemeViewModel _themeViewModel = Get.find();

    _themeViewModel.changeTheme(_consolidatedWeather.weatherStateAbbr!);

    MyTheme myTheme = _themeViewModel.myTheme;
    MaterialColor color = myTheme.color;

    return Center(
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          height: context.ultraHighValueHeight * 3,
          width: context.ultraHighValueWidth * 3.3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color[700]!, color[500]!, color[200]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.6, 0.8, 1]),
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: context.normalValueHeight,
              ),
              Text(
                _weather.title!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(
                height: context.lowValueHeight,
              ),
              Text(
                "Son güncelleme : " +
                    TimeOfDay.fromDateTime(_weather.time!.toLocal())
                        .format(context),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: context.lowValueHeight,
              ),
              Text(
                _consolidatedWeather.theTemp!.toInt().toString() + " ℃",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: 150,
                  child: Image.network(
                      "https://www.metaweather.com/static/img/weather/png/" +
                          _consolidatedWeather.weatherStateAbbr! +
                          ".png"),
                ),
              ),
              Padding(
                padding: context.paddingNormalHorizontal * 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Minumum: " +
                          _consolidatedWeather.minTemp!.toInt().toString() +
                          " ℃",
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "Maksimum: " +
                          _consolidatedWeather.maxTemp!.toInt().toString() +
                          " ℃",
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchButton() {
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

  Widget buildSettingsButton() {
    WeatherViewModel _weatherViewModel = Get.find();
    return IconButton(
      onPressed: () {
        Get.to(SettingsPage());
      },
      icon: Icon(Icons.settings),
    );
  }
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserAuthViewModel _userAuthViewModel = Get.find();
    WeatherViewModel _weatherViewModel = Get.put(WeatherViewModel());
    ThemeViewModel _themeViewModel = Get.put(ThemeViewModel());

    return Obx(
        () => buildScaffold(_userAuthViewModel, context, _themeViewModel));
  }

  Widget buildScaffold(UserAuthViewModel myAuth, BuildContext context,
      ThemeViewModel _themeViewModel) {
    WeatherViewModel _weatherViewModel = Get.find();
    var weatherState = _weatherViewModel.weatherState;

    switch (weatherState) {
      case WeatherState.weatherInitial:
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
                " Weather -${myAuth.user == null ? "usernull" : myAuth.user!.email!.substring(0, 6)} "),
            actions: [buildSearchButton(), buildSettingsButton()],
          ),
          body: const Center(
            child: Text("plese search a city"),
          ),
        );
      case WeatherState.weatherLoaded:
        return WeatherLoaded();
      case WeatherState.weatherRefresh:
        return WeatherLoaded();

      case WeatherState.weatherLoading:
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
                " Weather -${myAuth.user == null ? "usernull" : myAuth.user!.email!.substring(0, 6)} "),
            actions: [buildSearchButton(), buildSettingsButton()],
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );

      case WeatherState.weatherLoadingError:
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
                " Weather -${myAuth.user == null ? "usernull" : myAuth.user!.email!.substring(0, 6)} "),
            actions: [buildSearchButton(), buildSettingsButton()],
          ),
          body: const Center(
            child: Text("hava durumu getirilirken bir hata oldu :)"),
          ),
        );
    }
  }

  Widget buildSearchButton() {
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

  Widget buildSettingsButton() {
    WeatherViewModel _weatherViewModel = Get.find();
    return IconButton(
      onPressed: () {
        Get.to(SettingsPage());
      },
      icon: Icon(Icons.settings),
    );
  }
}
