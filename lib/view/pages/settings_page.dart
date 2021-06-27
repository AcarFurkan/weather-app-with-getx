import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/utils/extentions/context_extension.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/settings_viewmodel.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/theme/dark_light_theme_controller.dart';

import 'initial_page.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  Completer<void> _refreshIndicator = Completer<void>();
  SettingsViewModel _settingsViewModel = Get.put(SettingsViewModel());
  DarkLightThemeController _darkLightThemeController =
      Get.put(DarkLightThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings Page"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _refreshIndicator.future;
        },
        child: ListView(
          children: [
            Obx(() {
              return SwitchListTile(
                  value: _darkLightThemeController.darkThemeIsOpen,
                  title: Text("Dark Mode"),
                  onChanged: (x) {
                    Get.changeTheme(Get.isDarkMode
                        ? ThemeData.light().copyWith(primaryColor: Colors.teal)
                        : ThemeData.dark());
                    _darkLightThemeController.darkThemeIsOpen = x;
                  });
            }),
            Padding(
              padding: context.paddingHighHorizontal,
              child: OutlinedButton(
                  onPressed: () async {
                    _settingsViewModel.signOut();
                    Get.offAll(Root());
                  },
                  child: Text("Sign Out")),
            ),
            Padding(
              padding: context.paddingHighHorizontal,
              child: OutlinedButton(
                  onPressed: () async {}, child: Text("Refresh trial")),
            ),
          ],
        ),
      ),
    );
  }
}
