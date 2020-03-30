import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static ThemeData buildLightTheme(BuildContext context) {
    ThemeData base = ThemeData.light();
    return base.copyWith(
      appBarTheme: appBarTheme(),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
        textTheme: TextTheme(
            title: TextStyle(
          color: AppColors.appBarText,
          fontSize: 20,
        )),
        color: AppColors.scaffoldBackground,
        iconTheme: IconThemeData(
          color: AppColors.appBarBackButton,
        ));
  }
}
