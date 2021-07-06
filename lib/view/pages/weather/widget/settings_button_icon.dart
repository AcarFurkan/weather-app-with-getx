import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../settings_page.dart';

class SettingsButtonIcon extends StatelessWidget {
  SettingsButtonIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.to(SettingsPage());
      },
      icon: Icon(Icons.settings),
    );
  }
}
