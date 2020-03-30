import 'dart:async';

import 'package:deeplinktest/data/service_interfaces/service_auth.dart';
import 'package:deeplinktest/data/services/service_auth_http.dart';
import 'package:deeplinktest/data/utils/data_utils.dart';
import 'package:deeplinktest/domain/models/sign_in_user.dart';
import 'package:deeplinktest/domain/models/sign_up_user.dart';
import 'package:deeplinktest/domain/models/user.dart';

enum RepoAuthState { SignedIn, SignedOut }

class AuthResponse {
  final User user;
  final String exception;

  AuthResponse(this.user, this.exception);
}

class AuthRepository {
  User _user;
  ServiceAuth authService = ServiceAuthHttp();
  StreamController<RepoAuthState> _authStateStreamController =
      StreamController<RepoAuthState>.broadcast();

  Stream<RepoAuthState> getAuthStateStream() {
    return _authStateStreamController.stream;
  }

  ///Nullable
  User get user => _user;

  Future<AuthResponse> signIn(SignInUser signInUser) async {
    bool isInternet = await DataUtils.isInternetConnected();

    if(!isInternet)
      return AuthResponse(null, "Check internet connection");

    AuthResponse response = await authService.signIn(signInUser);

    if(response.user != null){
      //save user to be the only source of truth
      _user = response.user;
      //broadcast new auth status
      _authStateStreamController.add(RepoAuthState.SignedIn);
    }else{
      _user = null;
      //broadcast new auth status
      _authStateStreamController.add(RepoAuthState.SignedOut);
    }
    return response;
  }

  Future<AuthResponse> signUp(SignUpUser signUpUser) async{
    bool isInternet = await DataUtils.isInternetConnected();

    if(!isInternet)
      return AuthResponse(null, "Check internet connection");

    AuthResponse response = await authService.signUp(signUpUser);
    if(response.user != null){
      //save user to be the only source of truth
      _user = response.user;
      //broadcast new auth status
      _authStateStreamController.add(RepoAuthState.SignedIn);
    }else{
      _user = null;
      //broadcast new auth status
      _authStateStreamController.add(RepoAuthState.SignedOut);
    }
    return response;
  }

  void close() {
    _authStateStreamController.close();
  }
}
