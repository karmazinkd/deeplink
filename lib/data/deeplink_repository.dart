import 'dart:async';

import 'package:deeplinktest/data/service_interfaces/service_deeplink.dart';
import 'package:deeplinktest/data/services/service_deeplink_uni.dart';
import 'package:deeplinktest/domain/utils/logger_setup.dart';
import 'package:logger/logger.dart';

class DeepLinkRepository {
  final log = Logger(printer: LoggerSetup("DeepLinkRepository"));
  ServiceDeepLink _deepLinkService = ServiceDeeplinkUni();

  ///Returns a stream of incoming events of clicking on registered deep links for this app
  Stream<String> getDeepLinkStream() {
    try {
      return _deepLinkService.getDeepLinksStream();
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  ///Returns the initial value of deep link assigned if the app was opened via deep link
  ///Nullable
  Future<String> fetchDeepLinkInitialValue() async {
    return await _deepLinkService.fetchDeepLinkInitialValue();
  }
}
