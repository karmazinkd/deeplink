import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppStyles {
  static const TextStyle content = TextStyle(
    fontSize: 18,
  );

  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static ThemeData buildLightTheme(BuildContext context) {
    ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryTextTheme: base.textTheme.copyWith(
        headline6: TextStyle(
          color: AppColors.loginButtonBlue,
        ),
      ),
      appBarTheme: appBarTheme(base.appBarTheme),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
    );
  }

  static AppBarTheme appBarTheme(AppBarTheme appBarTheme) {
    return appBarTheme.copyWith(
        elevation: 0,
        color: AppColors.scaffoldBackground,
        iconTheme: IconThemeData(
          color: AppColors.loginButtonBlue,
        ));
  }
}
