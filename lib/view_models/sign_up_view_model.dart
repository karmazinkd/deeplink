import 'dart:async';

import 'package:deeplinktest/data/auth_repository.dart';
import 'package:deeplinktest/domain/models/sign_in_user.dart';
import 'package:deeplinktest/domain/models/sign_up_user.dart';
import 'package:deeplinktest/domain/utils/validate_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class SignUpViewModel extends ChangeNotifier {
  AuthRepository _authRepository = GetIt.instance<AuthRepository>();
  StreamController<String> _snackbarStreamController =
      StreamController<String>.broadcast();
  String _emailInput = "", _passwordInput = "", _passwordConfirmInput = "";
  bool isAllValid = false;
  bool isLoading = false;

  ///Creates account based for email set in [_emailInput] with password set it [_passwordInput]
  ///returns Future<AuthResponse>
  Future<AuthResponse> signUp() async {
    isLoading = true;
    notifyListeners();
    AuthResponse response = await _authRepository.signUp(
      SignUpUser(
          email: _emailInput,
          password: _passwordInput,
          passwordConfirmation: _passwordConfirmInput),
    );
    isLoading = false;
    notifyListeners();

    if (response.exception != null) {
      showSnackbar(response.exception);
    }

    return response;
  }

  Stream<String> getSnackbarStream() {
    return _snackbarStreamController.stream;
  }

  ///Validates the email set in [_emailInput]
  ///Returns `null` on successful validation, otherwise returns String with the failure message
  ///Nullable
  String validateEmail() {
    return ValidateUtil.validateEmail(_emailInput);
  }

  ///Updates email validation with the new value of the email and then performs validation
  void updateEmailInput(String email) {
    _emailInput = email;
    _checkIfAllInputValid();
  }

  ///Validates the password set in [_passwordInput]
  ///Returns `null` on successful validation, otherwise returns String with the failure message
  ///Nullable
  String validatePassword() {
    return ValidateUtil.validatePassword(_passwordInput);
  }

  ///Updates password validation with the new value of the password and then performs validation
  void updatePasswordInput(String password) {
    _passwordInput = password;
    _checkIfAllInputValid();
  }

  ///Validates the given passwords for confirmation.
  ///Returns `null` on successful validation, otherwise String with the failure message
  ///Nullable
  String validateConfirmPassword() {
    return ValidateUtil.validateConfirmPassword(_passwordInput, _passwordConfirmInput);
  }

  ///Updates password confirm validation with the new value of the password and then performs validation
  void updateConfirmPasswordInput(String confirmPassword) {
    _passwordConfirmInput = confirmPassword;
    _checkIfAllInputValid();
  }

  ///Checks validation for all input fields
  void _checkIfAllInputValid() {
    if (validateEmail() == null && validatePassword() == null && validateConfirmPassword() == null
    && _passwordInput == _passwordConfirmInput) {
      if (!isAllValid) {
        isAllValid = true;
        notifyListeners();
      }
    } else {
      if (isAllValid) {
        isAllValid = false;
        notifyListeners();
      }
    }
  }

  void showSnackbar(String message) {
    if (message != null) _snackbarStreamController.add(message);
  }

  ///Clears the user inputs, should be called when the page is disposed
  void clear() {
    _emailInput = "";
    _passwordInput = "";
    _passwordConfirmInput = "";
    isAllValid = false;
  }

  @override
  void dispose() {
    _snackbarStreamController.close();
    super.dispose();
  }
}
