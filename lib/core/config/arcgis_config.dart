import 'package:transitops_gis/core/config/app_config.dart';
import 'package:transitops_gis/core/config/app_environment.dart';

/// GIS-specific configuration. Secrets are injected at compile time, never hardcoded.
class ArcGISConfig {
  const ArcGISConfig({
    required this.apiKey,
    required this.portalUrl,
    required this.environment,
    this.basemapStyleId = ArcGISBasemapStyleId.streets,
  });

  factory ArcGISConfig.fromAppConfig(AppConfig config) {
    return ArcGISConfig(
      apiKey: config.arcgisApiKey,
      portalUrl: config.arcgisPortalUrl,
      environment: config.environment,
    );
  }

  final String apiKey;
  final String portalUrl;
  final AppEnvironment environment;
  final ArcGISBasemapStyleId basemapStyleId;

  bool get hasApiKey => apiKey.isNotEmpty;
}

enum ArcGISBasemapStyleId { streets, navigation, lightGray, imagery }
