import 'package:get/get.dart';

class DarkLightThemeController extends GetxController {
  var _darkThemeIsOpen = false.obs;

  get darkThemeIsOpen => _darkThemeIsOpen.value;

  set darkThemeIsOpen(value) {
    _darkThemeIsOpen.value = value;
  }
}
