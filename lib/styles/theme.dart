import 'package:flutter/material.dart';
import 'package:grocery_app/styles/colors.dart';

ThemeData themeData = ThemeData(
  fontFamily: "Pretendard",
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor),
);
