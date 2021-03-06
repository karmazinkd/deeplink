import 'dart:async';

import 'package:deeplinktest/data/auth_repository.dart';
import 'package:deeplinktest/domain/models/sign_in_user.dart';
import 'package:deeplinktest/domain/utils/validate_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class SignInViewModel extends ChangeNotifier{
  AuthRepository _authRepository = GetIt.instance<AuthRepository>();
  StreamController<String> _snackbarStreamController = StreamController<String>.broadcast();
  String _emailInput, _passwordInput = "";
  bool isAllValid = false;
  bool isLoading = false;

  ///Performs a sign-in, updates UI with the result
  Future<AuthResponse> signIn() async{
    isLoading = true;
    notifyListeners();
    AuthResponse response = await _authRepository.signIn(SignInUser(_emailInput, _passwordInput));
    isLoading = false;
    notifyListeners();
    if(response.exception != null){
      showSnackbar(response.exception);
    }

    return response;
  }

  Stream<String> getSnackbarStream(){
    return _snackbarStreamController.stream;
  }

  ///Validates [_emailInput] as an email
  ///Returns `null` on successful validation, otherwise String with failure message
  ///Nullable
  String validateEmail(){
      return ValidateUtil.validateEmail(_emailInput);
  }

  ///Updates email validation with the new value of the email and then performs validation
  void updateEmailInput(String email){
    _emailInput = email;
    checkIfAllInputValid();
  }

  ///Validates the password set in [_passwordInput]
  ///Returns `null` on successful validation, otherwise returns String with the failure message
  ///Nullable
  String validatePassword(){
    return ValidateUtil.validatePassword(_passwordInput);
  }

  ///Updates password validation with the new value of the password and then performs validation
  void updatePasswordInput(String password){
    _passwordInput = password;
    checkIfAllInputValid();
  }

  ///Checks validation for all input fields
  void checkIfAllInputValid(){
    if(validateEmail() == null && validatePassword() == null){

      if(!isAllValid) {
        isAllValid = true;
        notifyListeners();
      }
    }else{
      if(isAllValid){
        isAllValid = false;
        notifyListeners();
      }
    }

  }

  void showSnackbar(String message) {
    if(message != null)
      _snackbarStreamController.add(message);
  }

  ///Clears the user inputs, should be called when the page is disposed
  void clear(){
    _emailInput = "";
    _passwordInput = "";
    isAllValid = false;
  }

  @override
  void dispose() {
    _snackbarStreamController.close();
    super.dispose();
  }
}