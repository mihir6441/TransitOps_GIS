import 'package:transitops_gis/core/config/app_environment.dart';

/// Application configuration loaded from compile-time environment values.
///
/// Secrets (including a future ArcGIS API key) must be supplied via
/// `--dart-define` or a local untracked file — never hardcoded.
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.arcgisApiKey,
    required this.arcgisPortalUrl,
  });

  factory AppConfig.fromEnvironment() {
    const envName = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'development',
    );
    const apiBaseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.example.invalid/v1',
    );
    const arcgisApiKey = String.fromEnvironment('ARCGIS_API_KEY');
    const arcgisPortalUrl = String.fromEnvironment(
      'ARCGIS_PORTAL_URL',
      defaultValue: 'https://www.arcgis.com',
    );

    return AppConfig(
      environment: AppEnvironment.fromName(envName),
      apiBaseUrl: apiBaseUrl,
      arcgisApiKey: arcgisApiKey,
      arcgisPortalUrl: arcgisPortalUrl,
    );
  }

  final AppEnvironment environment;
  final String apiBaseUrl;

  /// Empty until provided via `--dart-define=ARCGIS_API_KEY=...`
  /// or `--dart-define-from-file=dart_defines.json`.
  final String arcgisApiKey;
  final String arcgisPortalUrl;

  bool get hasArcgisApiKey => arcgisApiKey.isNotEmpty;
}
