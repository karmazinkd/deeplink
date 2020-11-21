import 'package:deeplinktest/domain/models/sign_in_user.dart';
import 'package:deeplinktest/domain/models/sign_up_user.dart';
import '../auth_repository.dart';

abstract class ServiceAuth{
  String failureMessageNoInternetConnection;
  String failureMessageRequestFailed;
  String failureMessageFailedToParseResponse;
  Future<AuthResponse> signIn(SignInUser user);
  Future<AuthResponse>  signUp(SignUpUser user);
}