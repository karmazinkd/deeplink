import 'package:deeplinktest/ui/utils/app_colors.dart';
import 'package:deeplinktest/ui/utils/strings.dart';
import 'package:flutter/material.dart';

import 'package:deeplinktest/ui/utils/app_styles.dart';

class DeepLinkPage extends StatelessWidget {
  static const routeName = "/deepLinkPage";

  @override
  Widget build(BuildContext context) {
    String deeplink = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.deepLinkDemoPage),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.link, size: 70, color: AppColors.loginButtonBlue),
          SizedBox(
            height: 12.0,
          ),
          Text(
            Strings.deepLinkReceived,
            textAlign: TextAlign.center,
            style: AppStyles.title,
          ),
          Text(
            deeplink,
            textAlign: TextAlign.center,
            style: AppStyles.content,
          ),
        ],
      ),
    );
  }
}
