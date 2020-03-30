import 'package:deeplinktest/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DeepLinkPage extends StatelessWidget {
  static const routeName = "/deepLinkPage";

  @override
  Widget build(BuildContext context) {
    String deeplink = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Deep pink display page"),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.important_devices,
              size: 50, color: AppColors.appBarBackButton),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: Text(
              "DEEP LINK: $deeplink",
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
