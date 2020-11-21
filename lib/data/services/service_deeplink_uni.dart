import 'dart:async';

import 'package:deeplinktest/data/service_interfaces/service_deeplink.dart';
import 'package:deeplinktest/domain/utils/logger_setup.dart';
import 'package:logger/logger.dart';
import 'package:uni_links/uni_links.dart';

///This deep link service ias based on uni_links plugin
class ServiceDeeplinkUni implements ServiceDeepLink {
  final log = Logger(printer: LoggerSetup("ServiceDeeplinkUni"));


  ///Returns the initial value of deep link, it is non-null if the app was opened via deep link
  ///Nullable
  @override
  Future<String> fetchDeepLinkInitialValue() async {
    return await getInitialLink();
  }

  ///Returns a stream of incoming events of clicking on registered deep links for this app
  @override
  Stream<String> getDeepLinksStream() {
    return getLinksStream();
  }
}
