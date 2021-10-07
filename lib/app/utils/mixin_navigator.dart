import 'package:breakingbad/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin AppNavigator {

   Future<dynamic>? navigate(Widget screen) {
    return navigatorKey.currentState?.push(_getRoute(screen));
  }

  Future<dynamic>? navigateUntil(Widget screen) {
    return navigatorKey.currentState?.pushAndRemoveUntil(_getRoute(screen), (_) => false);
  }

  Future<dynamic>? navigateReplace(Widget screen) {
    return navigatorKey.currentState?.pushReplacement(_getRoute(screen));
  }

  static _getRoute(Widget screen) => MaterialPageRoute(builder: (_) => screen);
}