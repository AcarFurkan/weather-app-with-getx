import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather_auth_app_with_bloc/view/pages/initial_page.dart';
import 'package:weather_auth_app_with_bloc/view/pages/internet_connection.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/provider/user_view_model.dart';

import 'utils/locator/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserAuthViewModel(),
      child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: InternetConnection(child: Root())),
    );
  }
}
