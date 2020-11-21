import 'dart:async';

import 'package:deeplinktest/data/auth_repository.dart';
import 'package:deeplinktest/ui/components/login_button.dart';
import 'package:deeplinktest/ui/utils/app_colors.dart';
import 'package:deeplinktest/ui/utils/strings.dart';
import 'package:deeplinktest/ui/utils/ui_utils.dart';
import 'package:deeplinktest/view_models/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  static const routeName = "/SignInPage";

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();

  StreamSubscription<String> snackBarSubscription;
  double buttonWidth;
  SignInViewModel _model;


  @override
  void initState() {
    super.initState();
    _model = Provider.of<SignInViewModel>(context, listen: false);
    snackBarSubscription =
        _model.getSnackbarStream().listen((message) => showSnackBar(message));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    buttonWidth = UiUtils.wideButtonWidth(context);
  }

  @override
  Widget build(BuildContext context) {
    _model = Provider.of<SignInViewModel>(context);
    return ModalProgressHUD(
      inAsyncCall: _model.isLoading,
      dismissible: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(Strings.signIn),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: _buildInputForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputForm() {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: buttonWidth,
          child: Column(
            children: <Widget>[
              TextFormField(
                key: _emailKey,
                decoration: const InputDecoration(
                    labelText: Strings.email, hintText: Strings.emailExample),
                keyboardType: TextInputType.emailAddress,
                validator: (_) => _model.validateEmail(),
                onChanged: (value) {
                  _model.updateEmailInput(value);
                  _emailKey.currentState.validate();
                },
              ),
              TextFormField(
                key: _passwordKey,
                decoration: const InputDecoration(
                    labelText: Strings.password, hintText: Strings.emailHint),
                keyboardType: TextInputType.text,
                validator: (_) => _model.validatePassword(),
                obscureText: true,
                onChanged: (value) {
                  _model.updatePasswordInput(value);
                  _passwordKey.currentState.validate();
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              LoginButton(
                backgroundColor: AppColors.loginButtonBlue,
                backgroundDisabledColor: AppColors.loginButtonDisabledBlue,
                textColor: Colors.white,
                text:  Strings.signIn,
                buttonWidth: buttonWidth,
                onTap: _model.isAllValid ? _onSignInPressed : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSignInPressed() async{
    AuthResponse response = await _model.signIn();
    if(response.user != null)
      Navigator.of(context).pop();
  }

  void showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    snackBarSubscription.cancel();
    _model.clear();
    super.dispose();
  }
}
