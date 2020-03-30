import 'package:deeplinktest/data/auth_repository.dart';
import 'package:deeplinktest/data/deeplink_repository.dart';
import 'package:deeplinktest/ui/pages/deeplink_page.dart';
import 'package:deeplinktest/ui/pages/home_page.dart';
import 'package:deeplinktest/ui/pages/landing_page.dart';
import 'package:deeplinktest/ui/pages/login_page.dart';
import 'package:deeplinktest/ui/pages/sign_up_page.dart';
import 'package:deeplinktest/ui/pages/sign_in_page.dart';
import 'package:deeplinktest/ui/utils/app_styles.dart';
import 'package:deeplinktest/view_models/home_page_view_model.dart';
import 'package:deeplinktest/view_models/landing_page_view_model.dart';
import 'package:deeplinktest/view_models/sign_in_view_model.dart';
import 'package:deeplinktest/view_models/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
//needed for async initialization if it's prior to runApp()

  //set up locators
  GetIt.I.registerSingleton<DeepLinkRepository>(DeepLinkRepository());
  GetIt.I.registerSingleton<AuthRepository>(AuthRepository());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignInViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignUpViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomePageViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => LandingPageViewModel(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Deeplink Demo',
        theme: AppStyles.buildLightTheme(context),
        home: LandingPage(),
        routes: <String, WidgetBuilder>{
          DeepLinkPage.routeName: (context) => DeepLinkPage(),
          LoginPage.routeName: (context) => LoginPage(),
          SignInPage.routeName: (context) => SignInPage(),
          SignUpPage.routeName: (context) => SignUpPage(),
          HomePage.routeName: (context) => HomePage(),
        },
      ),
    );
  }
}
