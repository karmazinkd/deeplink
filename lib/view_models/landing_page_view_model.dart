import 'dart:async';

import 'package:deeplinktest/data/auth_repository.dart';
import 'package:deeplinktest/data/deeplink_repository.dart';
import 'package:deeplinktest/domain/utils/logger_setup.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class LandingPageViewModel extends ChangeNotifier {
  final log = Logger(printer: LoggerSetup("LandingPageViewModel"));

  DeepLinkRepository _deepLinkProvider = GetIt.instance<DeepLinkRepository>();
  AuthRepository _authRepository = GetIt.instance<AuthRepository>();

  StreamSubscription<String> _deeplinkProviderSub;

  StreamController<String> _deeplinkValueStream =
      StreamController<String>.broadcast();

  Stream<String> streamDeeplinkValues() => _deeplinkValueStream.stream;

  StreamSubscription<RepoAuthState> _authStateSub;

  RepoAuthState _authState = RepoAuthState.SignedOut;

  RepoAuthState get authState => _authState;

  LandingPageViewModel() {
    _listenToDeeplinkChanges();
    _listenToAuthState();
  }

  void _listenToDeeplinkChanges() {
    _deeplinkProviderSub = _deepLinkProvider.getDeepLinkStream().listen(
      (data) {
        if(data != null)
          _deeplinkValueStream.add(data);
      },
      onError: (err) {
        log.e(err);
      },
    );
  }

  void _listenToAuthState(){
    _authStateSub = _authRepository.getAuthStateStream().listen(
          (state) {
            _authState = state;
            notifyListeners();
      },
      onError: (err) {
        log.e(err);
      },
    );
  }

  ///Nullable
  Future<String> checkInitialDeeplink() async {
    return await _deepLinkProvider.fetchDeepLinkInitialValue();
  }

  @override
  void dispose() {
    _deeplinkProviderSub.cancel();
    _deeplinkValueStream.close();
    _authStateSub.cancel();
    super.dispose();
  }
}
