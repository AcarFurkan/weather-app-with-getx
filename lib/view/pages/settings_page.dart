import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/utils/extentions/context_extension.dart';
import 'package:weather_auth_app_with_bloc/view/pages/register_page.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/settings_viewmodel.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/theme/dark_light_theme_controller.dart';

import 'drawer.dart';
import 'initial_page.dart';
import 'login_page.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  SettingsViewModel _settingsViewModel = Get.put(SettingsViewModel());
  DarkLightThemeController _darkLightThemeController =
      Get.put(DarkLightThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings Page"),
      ),
      body: ListView(
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
                onPressed: () {
                  // Get.offAll(page)
                  // Get.offAll(Trial());
                },
                child: Text("drawer trial")),
          ),
        ],
      ),
    );
  }
}

class Trial extends StatefulWidget {
  const Trial({Key? key}) : super(key: key);

  @override
  _TrialState createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App"),
      ),
      body: ZoomDrawer(
        clipMainScreen: false,
        controller: _zoomDrawerController,
        style: DrawerStyle.DefaultStyle,
        menuScreen: LoginPage(),
        mainScreen: RegisterPage(),
        borderRadius: 24.0,
        showShadow: true,
        angle: -12.0,
        backgroundColor: Colors.grey[300]!,
        slideWidth: MediaQuery.of(context).size.width * .65,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      ),
    );
  }
}
