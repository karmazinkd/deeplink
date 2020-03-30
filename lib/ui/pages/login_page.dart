import 'package:deeplinktest/ui/components/login_button.dart';
import 'package:deeplinktest/ui/pages/sign_up_page.dart';
import 'package:deeplinktest/ui/pages/sign_in_page.dart';
import 'package:deeplinktest/ui/utils/app_colors.dart';
import 'package:deeplinktest/ui/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/loginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _pageKey = GlobalKey<ScaffoldState>();

  double buttonWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    buttonWidth = UiUtils.wideButtonWidth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _pageKey,
        body: Center(
          child: Column(
            children: <Widget>[
              Spacer(),
              LoginButton(
                textColor: Colors.white,
                backgroundColor: AppColors.loginButtonBlue,
                text: "Sign up with Facebook",
                buttonWidth: buttonWidth,
                onTap: openFacebookRegistration,
              ),
              SizedBox(height: 12.0),
              LoginButton(
                textColor: Colors.white,
                backgroundColor: AppColors.loginButtonRed,
                text: "Sign up with email",
                buttonWidth: buttonWidth,
                onTap: openEmailRegistration,
              ),
              SizedBox(height: 12.0),
              LoginButton(
                textColor: Colors.black54,
                backgroundColor: Colors.white,
                text: "Sign in",
                buttonWidth: buttonWidth,
                onTap: openSignInPage,
              ),
              SizedBox(height: 36.0),
            ],
          ),
        ));
  }

  void openFacebookRegistration() {}

  void openEmailRegistration() {
    Navigator.of(context).pushNamed(SignUpPage.routeName);
  }

  void openSignInPage() {
    Navigator.of(context).pushNamed(SignInPage.routeName);
  }
}


