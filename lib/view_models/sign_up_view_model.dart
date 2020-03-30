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

  ///Nullable
  String validateEmail() {
    return ValidateUtil.validateEmail(_emailInput);
  }

  void updateEmailInput(String email) {
    _emailInput = email;
    checkIfAllInputValid();
  }

  ///Nullable
  String validatePassword() {
    return ValidateUtil.validatePassword(_passwordInput);
  }

  void updatePasswordInput(String password) {
    _passwordInput = password;
    checkIfAllInputValid();
  }

  ///Nullable
  String validateConfirmPassword() {
    return ValidateUtil.validateConfirmPassword(_passwordInput, _passwordConfirmInput);
  }

  void updateConfirmPasswordInput(String confirmPassword) {
    _passwordConfirmInput = confirmPassword;
    checkIfAllInputValid();
  }

  void checkIfAllInputValid() {
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
