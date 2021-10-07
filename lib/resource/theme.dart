import 'package:breakingbad/resource/color_palette.dart';
import 'package:flutter/material.dart';


final appTheme = ThemeData(
  primaryColor: kColorPrimary,
  colorScheme:  ThemeData().colorScheme.copyWith(secondary: kColorAccent),
  appBarTheme: const AppBarTheme(
     backgroundColor: kColorPrimary
  )
);

