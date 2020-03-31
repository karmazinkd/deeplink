import 'dart:convert';

import 'package:deeplinktest/data/auth_repository.dart';
import 'package:deeplinktest/data/service_interfaces/service_auth.dart';
import 'package:deeplinktest/data/utils/ServiceConstants.dart';
import 'package:deeplinktest/domain/models/sign_in_user.dart';
import 'package:deeplinktest/domain/models/sign_up_user.dart';
import 'package:deeplinktest/domain/models/user.dart';
import 'package:deeplinktest/domain/utils/logger_setup.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ServiceAuthHttp implements ServiceAuth {
  final log = Logger(printer: LoggerSetup("ServiceAuthHttp"));

  @override
  Future<AuthResponse> signIn(SignInUser user) async {
    String url = '${ServiceConstants.baseUrl}${ServiceConstants.login}';

    Map<String, String> headers = {
      "accept": "application/json",
    };

    Map<String, String> jsonBody = {
      "email": user.email,
      "password": user.password
    };
    Response response = await post(url, headers: headers, body: jsonBody);

    log.d("signIn response body: ${response.body}");

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body)['data'];
      User user = User.fromJson(decoded);

      if (user.isValid())
        return AuthResponse(user, null);
      else
        return AuthResponse(null, "Failed to parse the response");
    }

    return AuthResponse(null, "Failed to sign in");
  }

  @override
  Future<AuthResponse> signUp(SignUpUser signUpUser) async {
    String url = '${ServiceConstants.baseUrl}${ServiceConstants.register}';

    Map<String, String> headers = {
      "accept": "application/json",
    };

    Map<String, String> jsonBody = {
      "email": signUpUser.email,
      "password": signUpUser.password,
      "password_confirmation": signUpUser.passwordConfirmation,
    };

    Response response = await post(url, headers: headers, body: jsonBody);

    log.d("signUp response body: ${response.body}");

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body)['data'];
      User user = User.fromJson(decoded);

      if (user.isValid())
        return AuthResponse(user, null);
      else
        return AuthResponse(null, "Failed to parse the response");
    }

    return AuthResponse(null, "Failed to sign up");
  }
}
