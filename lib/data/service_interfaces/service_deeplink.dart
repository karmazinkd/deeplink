abstract class ServiceDeepLink{
  Stream<String> getDeepLinksStream();
  Future<String> fetchDeepLinkInitialValue();
}