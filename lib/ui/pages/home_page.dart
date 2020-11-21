import 'package:deeplinktest/ui/utils/app_colors.dart';
import 'package:deeplinktest/ui/utils/strings.dart';
import 'package:deeplinktest/view_models/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:deeplinktest/ui/utils/app_styles.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/homePage";

  @override
  Widget build(BuildContext context) {
    HomePageViewModel _model = Provider.of<HomePageViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.homePage),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.home, size: 70, color: AppColors.loginButtonBlue),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: Text(
              Strings.welcomeToTheAppUserX.replaceFirst("%", _model.getUser().toString()),
              textAlign: TextAlign.center,
              style: AppStyles.content,
            ),
          ),
        ],
      ),
    );
  }
}
