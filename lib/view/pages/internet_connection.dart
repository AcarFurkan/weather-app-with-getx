import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

class InternetConnection extends StatefulWidget {
  InternetConnection({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  _InternetConnectionState createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      print(result.toString() + "aaaaaaaaaaaaaaaaaaaaa");
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:

      case ConnectivityResult.mobile:

      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        print(_connectionStatus);

        switch (result) {
          case ConnectivityResult.wifi:
            Get.snackbar(
              "Wifi ile bağlandınız",
              " Wifi ile bağlandınız",
              snackPosition: SnackPosition.BOTTOM,
            );
            break;
          case ConnectivityResult.mobile:
            Get.snackbar(
                "Mobil veri ile bağlandınız", " Mobil veri ile bağlandınız",
                snackPosition: SnackPosition.BOTTOM);
            break;
          case ConnectivityResult.none:
            Get.snackbar(
                " Internet bağlantısı kesildi", "  Internet bağlantısı kesildi",
                snackPosition: SnackPosition.BOTTOM);
            break;
        }

        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
}
