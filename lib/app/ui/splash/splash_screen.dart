import 'dart:async';

import 'package:breakingbad/app/data/repositories/character_repository.dart';
import 'package:breakingbad/app/ui/base/bloc_provider.dart';
import 'package:breakingbad/app/ui/home/bloc/home_bloc.dart';
import 'package:breakingbad/app/ui/home/home_screen.dart';
import 'package:breakingbad/app/utils/mixin_navigator.dart';
import 'package:breakingbad/app_configs.dart';
import 'package:breakingbad/resource/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:gap_widget/gap_widget.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AppNavigator {
  late StreamSubscription subscription;

  String appName = "";
  String imageSource = "";

  @override
  void initState() {

    init();
    subscription = Stream.periodic(const Duration(milliseconds: 2000))
        .take(1)
        .listen((event) {
      navigateUntil(const HomeScreen());
    });
    super.initState();
  }

  init()async {
    final packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    appName.contains("staging") ? imageLogoStaging.source : imageLogo.source;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    final appConfig = AppConfigs.of(context);

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(appConfig.logo), fit: BoxFit.cover)),
          ),
          VerticalGap(),
          Text(appConfig.appName)
        ],
      ),
    ));
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
