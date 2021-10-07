import 'package:breakingbad/app/ui/splash/splash_screen.dart';
import 'package:breakingbad/app_configs.dart';
import 'package:breakingbad/resource/assets_path.dart';
import 'package:breakingbad/resource/theme.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'app/ui/base/bloc_provider.dart';
import 'main.dart';

void main() async{
  runApp(const AppConfigs(
      flavour: 'staging', appName: 'Breaking Bad Staging', logo: 'assets/images/app_logo_staging.jpeg',
      child: MyApp()));
}