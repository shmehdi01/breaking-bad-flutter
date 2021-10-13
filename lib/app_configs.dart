import 'package:flutter/cupertino.dart';

class AppConfigs extends InheritedWidget {
  final String appName;
  final String flavor;
  final String baseUrl;
  final String logo;

  const AppConfigs(
      {Key? key,
      required this.appName,
      required this.flavor,
      required this.baseUrl,
        required this.logo,
      required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static AppConfigs of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfigs>()!;
  }
}
