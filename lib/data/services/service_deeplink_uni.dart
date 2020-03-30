import 'dart:async';

import 'package:deeplinktest/data/service_interfaces/service_deeplink.dart';
import 'package:deeplinktest/domain/utils/logger_setup.dart';
import 'package:logger/logger.dart';
import 'package:uni_links/uni_links.dart';

class ServiceDeeplinkUni implements ServiceDeepLink {
  final log = Logger(printer: LoggerSetup("ServiceDeeplinkUni"));


  ///Nullable
  @override
  Future<String> fetchDeepLinkInitialValue() async {
    return await getInitialLink();
  }

  @override
  Stream<String> getDeepLinksStream() {
    return getLinksStream();
  }
}
