/// Abstraction over ArcGISEnvironment so UI and tests never touch the SDK directly.
abstract class ArcGISRuntimeGateway {
  void applyApiKey(String apiKey);

  bool get isApiKeyApplied;
}
