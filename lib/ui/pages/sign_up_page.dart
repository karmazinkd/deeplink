import 'dart:async';

import 'package:deeplinktest/data/auth_repository.dart';
import 'package:deeplinktest/ui/components/login_button.dart';
import 'package:deeplinktest/ui/utils/app_colors.dart';
import 'package:deeplinktest/ui/utils/ui_utils.dart';
import 'package:deeplinktest/view_models/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = "/signUpPage";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordConfirmKey = GlobalKey<FormFieldState>();

  StreamSubscription<String> snackBarSubscription;
  double buttonWidth;
  SignUpViewModel _model;

  @override
  void initState() {
    super.initState();
    _model = Provider.of<SignUpViewModel>(context, listen: false);
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
    _model = Provider.of<SignUpViewModel>(context);
    return ModalProgressHUD(
      inAsyncCall: _model.isLoading,
      dismissible: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Sign up"),
          elevation: 0.0,
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
                    labelText: 'Email', hintText: "example@mail.com"),
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
                    labelText: 'Password', hintText: "8+ characters"),
                keyboardType: TextInputType.text,
                validator: (_) => _model.validatePassword(),
                obscureText: true,
                onChanged: (value) {
                  _model.updatePasswordInput(value);
                  _passwordKey.currentState.validate();
                },
              ),
              TextFormField(
                key: _passwordConfirmKey,
                decoration: const InputDecoration(
                    labelText: 'Confirm password', hintText: ""),
                keyboardType: TextInputType.text,
                validator: (_) => _model.validateConfirmPassword(),
                obscureText: true,
                onChanged: (value) {
                  _model.updateConfirmPasswordInput(value);
                  _passwordConfirmKey.currentState.validate();
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              LoginButton(
                backgroundColor: AppColors.loginButtonBlue,
                backgroundDisabledColor: AppColors.loginButtonDisabledBlue,
                textColor: Colors.white,
                text: "Sign up",
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
    AuthResponse response = await _model.signUp();
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
