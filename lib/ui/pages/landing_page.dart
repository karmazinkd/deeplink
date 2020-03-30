import 'package:deeplinktest/data/auth_repository.dart';
import 'package:deeplinktest/domain/utils/logger_setup.dart';
import 'package:deeplinktest/ui/pages/login_page.dart';
import 'package:deeplinktest/view_models/landing_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'deeplink_page.dart';
import 'home_page.dart';

class LandingPage extends StatefulWidget {
  static const routeName = "/";

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final log = Logger(printer: LoggerSetup("LandingPage"));
  LandingPageViewModel _model;

  @override
  void initState() {
    super.initState();
    _model = Provider.of<LandingPageViewModel>(context, listen: false);
    //deeplink may be updated at any given time, listen to the changes:
    listenToDeeplinkChanges();

    //check initial deeplink on app start:
    checkInitialDeeplink(_model);
  }

  void listenToDeeplinkChanges(){
    _model.streamDeeplinkValues().listen((deeplink) {
      showDeeplinkPageIfNeeded(deeplink);
    });
  }

  Future<void> checkInitialDeeplink(LandingPageViewModel model) async {
    String deeplink = await model.checkInitialDeeplink();
    showDeeplinkPageIfNeeded(deeplink);
  }

  void showDeeplinkPageIfNeeded(String deeplink) {
    if (deeplink != null)
      Navigator.of(context)
          .pushNamed(DeepLinkPage.routeName, arguments: deeplink);
  }

  @override
  Widget build(BuildContext context) {
    LandingPageViewModel model = Provider.of<LandingPageViewModel>(context);
    switch (model.authState) {
      case RepoAuthState.SignedOut:
        return LoginPage();
        break;
      case RepoAuthState.SignedIn:
        return HomePage();
        break;
      default:
        log.e("unexpected state ${model.authState}");
        return LoginPage();
    }
  }
}
