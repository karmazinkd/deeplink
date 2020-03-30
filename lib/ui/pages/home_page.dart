import 'package:deeplinktest/ui/utils/app_colors.dart';
import 'package:deeplinktest/view_models/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/homePage";

  @override
  Widget build(BuildContext context) {
    HomePageViewModel _model = Provider.of<HomePageViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Icon(Icons.home,
              size: 70, color: AppColors.appBarBackButton),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: Text(
              "Welcome to the app, ${_model.getUser()}!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
