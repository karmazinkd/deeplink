import 'package:deeplinktest/data/auth_repository.dart';
import 'package:deeplinktest/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class HomePageViewModel extends ChangeNotifier{

  AuthRepository _authRepository = GetIt.instance<AuthRepository>();

  ///Returns the logged in user
  ///Nullable
  User getUser(){
    return _authRepository.user;
  }
}