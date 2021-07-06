import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/utils/extensions/context_extension.dart';
import 'package:weather_auth_app_with_bloc/view/pages/register_page.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/settings_viewmodel.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/theme/dark_light_theme_controller.dart';

import 'drawer.dart';
import 'initial_page.dart';
import 'login_page.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final SettingsViewModel _settingsViewModel = Get.put(SettingsViewModel());
  final DarkLightThemeController _darkLightThemeController =
      Get.put(DarkLightThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Settings Page"),
    );
  }

  ListView buildBody(BuildContext context) {
    return ListView(
      children: [
        Obx(() {
          return buildDarkModeSwitch();
        }),
        Padding(
          padding: context.paddingHighHorizontal,
          child: buildSignOutButton(),
        ),
      ],
    );
  }

  SwitchListTile buildDarkModeSwitch() {
    return SwitchListTile(
        value: _darkLightThemeController.darkThemeIsOpen,
        title: const Text("Dark Mode"),
        onChanged: (x) {
          Get.changeTheme(Get.isDarkMode
              ? ThemeData.light().copyWith(primaryColor: Colors.teal)
              : ThemeData.dark());
          _darkLightThemeController.darkThemeIsOpen = x;
        });
  }

  OutlinedButton buildSignOutButton() {
    return OutlinedButton(
        onPressed: () async {
          _settingsViewModel.signOut();
          Get.offAll(const Root());
        },
        child: const Text("Sign Out"));
  }
}

class Trial extends StatefulWidget {
  const Trial({Key? key}) : super(key: key);

  @override
  _TrialState createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App"),
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
