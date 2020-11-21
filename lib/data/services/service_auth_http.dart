import 'dart:convert';

import 'package:deeplinktest/data/auth_repository.dart';
import 'package:deeplinktest/data/service_interfaces/service_auth.dart';
import 'package:deeplinktest/data/utils/data_utils.dart';
import 'package:deeplinktest/data/utils/service_constants.dart';
import 'package:deeplinktest/domain/models/sign_in_user.dart';
import 'package:deeplinktest/domain/models/sign_up_user.dart';
import 'package:deeplinktest/domain/models/user.dart';
import 'package:deeplinktest/domain/utils/logger_setup.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ServiceAuthHttp implements ServiceAuth {
  String failureMessageNoInternetConnection = "No internet connection";
  String failureMessageRequestFailed = "Request failed";
  String failureMessageFailedToParseResponse = "Failed to parse response";

  final log = Logger(printer: LoggerSetup("ServiceAuthHttp"));

  ///Signs-in with the given [signInUser]
  @override
  Future<AuthResponse> signIn(SignInUser signInUser) async {
    String url = '${ServiceConstants.baseUrl}${ServiceConstants.login}';

    Map<String, String> jsonBody = {"email": signInUser.email, "password": signInUser.password};

    return await _sendRequest(url, jsonBody);
  }

  ///Signs-up with the given [signUpUser]
  @override
  Future<AuthResponse> signUp(SignUpUser signUpUser) async {
    String url = '${ServiceConstants.baseUrl}${ServiceConstants.register}';

    Map<String, String> jsonBody = {
      "email": signUpUser.email,
      "password": signUpUser.password,
      "password_confirmation": signUpUser.passwordConfirmation,
    };

    return await _sendRequest(url, jsonBody);
  }

  ///Checks internet connection and if it's ok - sends the POST request to get the User data.
  ///Returns AuthResponse
  Future<AuthResponse> _sendRequest(String url, Map<String, String> jsonBody) async {
    bool isInternet = await DataUtils.isInternetConnected();

    if(!isInternet)
      return AuthResponse(null, failureMessageNoInternetConnection);

    Map<String, String> headers = {
      "accept": "application/json",
    };

    Response response = await post(url, headers: headers, body: jsonBody);
    log.d("post url: $url, request body: ${jsonBody.toString()}, response body: ${response.body}");

    return _handleResponse(response);
  }

  ///Prepares corresponding AuthResponse based on the given http [response]
  AuthResponse _handleResponse(Response response) {
    if (response.statusCode != 200) return AuthResponse(null, failureMessageRequestFailed);

    final decoded = json.decode(response.body)['data'];
    User user = User.fromJson(decoded);

    if (user.isValid())
      return AuthResponse(user, null);
    else
      return AuthResponse(null, failureMessageFailedToParseResponse);
  }
}
