import 'dart:async';

import 'package:breakingbad/app/ui/splash/splash_screen.dart';
import 'package:breakingbad/app_configs.dart';
import 'package:breakingbad/resource/color_palette.dart';
import 'package:breakingbad/resource/theme.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'app/data/network/api_config.dart';

void main() {
  runApp(const AppConfigs(
      flavor: 'production',
      baseUrl: 'https://www.breakingbadapi.com/api/',
      appName: 'Breaking Bad',
      logo: 'assets/images/app_logo.jpeg',
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    _internetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfigs.of(context);
    ApiConfig.initialize(baseUrl: appConfig.baseUrl);

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Breaking Bad Demo',
      theme: appTheme,
      home: const SplashScreen(),
    );
  }

  _internetConnection() {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      final manager = ScaffoldMessenger.of(navigatorKey.currentContext!);
      switch (event) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          manager.removeCurrentSnackBar();
          break;
        case ConnectivityResult.none:
          manager.showSnackBar(const SnackBar(
            content: Text("No Internet Connect"),
            backgroundColor: kColorAccent,
          ));
          break;
      }
    });
  }

  @override
  void dispose() {
    //subscription.cancel(); // Not cancelling, it will show no internet every screen with Snackbar
    super.dispose();
  }
}
