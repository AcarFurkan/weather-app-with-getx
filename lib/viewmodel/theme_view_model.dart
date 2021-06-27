import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/my_theme.dart';

class ThemeViewModel extends GetxController {
  Rx<MyTheme> _myTheme = Rx(MyTheme(Colors.blue, ThemeData.light()));

  MyTheme get myTheme => _myTheme.value;

  Rx<Color> _scaffoldColor = Rx(Colors.blueAccent);

  Color get scaffoldColor => _scaffoldColor.value;

  set scaffoldColor(Color value) {
    _scaffoldColor.value = value;
  }

  set myTheme(MyTheme value) {
    _myTheme.value = value;
  }

  void changeScaffoldTheme(String weatherAbbreviation) {
    Color _scaffoldColor = Colors.indigoAccent;
    print(111);
    switch (weatherAbbreviation) {
      case "sn":
      case "sl":
      case "h":
      case "t":
      case "hc":
        _scaffoldColor = Colors.blueGrey;
        break;

      case "hr":
      case "lr":
      case "s":
        _scaffoldColor = Colors.indigoAccent;
        break;

      case "lc":
      case "c":
        _scaffoldColor = Colors.orange;
        break;
    }
    scaffoldColor = _scaffoldColor;
  }

  void changeTheme(String weatherAbbreviation) {
    MyTheme? _tempTheme = MyTheme(Colors.blue, ThemeData.light());
    //Color _scaffoldColor = Colors.indigoAccent;
    print(111);
    switch (weatherAbbreviation) {
      case "sn":
      case "sl":
      case "h":
      case "t":
      case "hc":
        _tempTheme =
            MyTheme(Colors.grey, ThemeData(primaryColor: Colors.blueGrey));
        //  _scaffoldColor = Colors.blueGrey;
        break;

      case "hr":
      case "lr":
      case "s":
        _tempTheme = MyTheme(
            Colors.indigo, ThemeData(primaryColor: Colors.indigoAccent));
        //_scaffoldColor = Colors.indigoAccent;
        break;

      case "lc":
      case "c":
        _tempTheme = MyTheme(
            Colors.yellow, ThemeData(primaryColor: Colors.orangeAccent));
        //_scaffoldColor = Colors.orange;
        break;
    }
    // scaffoldColor = _scaffoldColor;
    myTheme = _tempTheme;
  }
}
