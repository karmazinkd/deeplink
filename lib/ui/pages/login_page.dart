import 'package:deeplinktest/ui/components/login_button.dart';
import 'package:deeplinktest/ui/pages/sign_up_page.dart';
import 'package:deeplinktest/ui/pages/sign_in_page.dart';
import 'package:deeplinktest/ui/utils/app_colors.dart';
import 'package:deeplinktest/ui/utils/strings.dart';
import 'package:deeplinktest/ui/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/loginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double buttonWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    buttonWidth = UiUtils.wideButtonWidth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                    child: Image.asset(
                  "assets/img_deeplink_logo.jpg",
                )),
              ),
              LoginButton(
                textColor: Colors.white,
                backgroundColor: AppColors.loginButtonBlue,
                text: Strings.signUpWithEmail,
                buttonWidth: buttonWidth,
                onTap: openEmailRegistration,
              ),
              SizedBox(height: 12.0),
              LoginButton(
                textColor: Colors.black87,
                backgroundColor: AppColors.loginButtonDisabledBlue,
                text: Strings.signIn,
                buttonWidth: buttonWidth,
                onTap: openSignInPage,
              ),
              SizedBox(height: 36.0),
            ],
          ),
        ));
  }

  void openEmailRegistration() {
    Navigator.of(context).pushNamed(SignUpPage.routeName);
  }

  void openSignInPage() {
    Navigator.of(context).pushNamed(SignInPage.routeName);
  }
}
