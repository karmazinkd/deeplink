import 'dart:async';

import 'package:deeplinktest/data/service_interfaces/service_auth.dart';
import 'package:deeplinktest/data/services/service_auth_http.dart';
import 'package:deeplinktest/domain/models/sign_in_user.dart';
import 'package:deeplinktest/domain/models/sign_up_user.dart';
import 'package:deeplinktest/domain/models/user.dart';
import 'package:deeplinktest/ui/utils/strings.dart';

enum RepoAuthState { SignedIn, SignedOut }

class AuthResponse {
  final User user;
  String exception;

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

  ///Returns the currently signed-in user
  ///Nullable
  User get user => _user;

  ///Signs-in with the given [signInUser] and updates the auth state
  Future<AuthResponse> signIn(SignInUser signInUser) async {
    AuthResponse response = await authService.signIn(signInUser);
    response = _processAuthResponse(response, Strings.failedToSignIn);
    return response;
  }

  ///Signs-up with the given [signUpUser] and updates the auth state
  Future<AuthResponse> signUp(SignUpUser signUpUser) async {
    AuthResponse response = await authService.signUp(signUpUser);
    response = _processAuthResponse(response, Strings.failedToSignUp);
    return response;
  }

  ///Updates the auth state and handles the failure message
  AuthResponse _processAuthResponse(AuthResponse response, String defaultFailureMessage) {
    _updateAuthState(response);
    return _handleFailureMessage(response, defaultFailureMessage);
  }

  ///Sends a stream event with a new auth state
  void _updateAuthState(AuthResponse response) {
    if (response.user != null) {
      //save user to be the only source of truth
      _user = response.user;
      //broadcast new auth status
      _authStateStreamController.add(RepoAuthState.SignedIn);
    } else {
      _user = null;
      //broadcast new auth status
      _authStateStreamController.add(RepoAuthState.SignedOut);
    }
  }

  ///Updates failure message with a user friendly texts
  AuthResponse _handleFailureMessage(AuthResponse response, String defaultFailureMessage) {
    if (response.exception == null) return response;

    if (response.exception == authService.failureMessageFailedToParseResponse) {
      response.exception = Strings.experiencingServerProblemsTryAgainLater;
    } else if (response.exception == authService.failureMessageRequestFailed) {
      response.exception = defaultFailureMessage;
    } else if (response.exception == authService.failureMessageNoInternetConnection) {
      response.exception = Strings.checkInternetConnection;
    }

    return response;
  }

  void close() {
    _authStateStreamController.close();
  }
}
