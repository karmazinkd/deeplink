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

  ///Listens to the incoming events of clicking on registered deep links for this app
  ///and emits a new deep link into the [_deepLinkValueStream] stream
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

  ///Listens to the auth state and updates [_authState] and notifies listeners on each change
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

  ///Returns the initial value of deep link assigned if the app was opened via deep link
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
