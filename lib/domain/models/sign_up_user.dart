import 'package:flutter/cupertino.dart';

class SignUpUser {
  final String name;
  final String email;
  final String lastName;
  final String middleName;
  final String phone;
  final String subscription;
  final String password;
  final passwordConfirmation;

  SignUpUser(
      {this.name,
      @required this.email,
      this.lastName,
      this.middleName,
      this.phone,
      this.subscription,
      @required this.password,
      @required this.passwordConfirmation});
}
