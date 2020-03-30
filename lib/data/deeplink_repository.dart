import 'dart:async';

import 'package:deeplinktest/data/service_interfaces/service_deeplink.dart';
import 'package:deeplinktest/data/services/service_deeplink_uni.dart';
import 'package:deeplinktest/domain/utils/logger_setup.dart';
import 'package:logger/logger.dart';

class DeepLinkRepository {
  final log = Logger(printer: LoggerSetup("DeepLinkRepository"));
  ServiceDeepLink _deepLinkService = ServiceDeeplinkUni();

  Stream<String> getDeepLinkStream() {
    try {
      return _deepLinkService.getDeepLinksStream();
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  ///Nullable
  Future<String> fetchDeepLinkInitialValue() async {
    return await _deepLinkService.fetchDeepLinkInitialValue();
  }
}
