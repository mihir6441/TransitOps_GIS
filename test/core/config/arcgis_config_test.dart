import 'package:flutter_test/flutter_test.dart';
import 'package:transitops_gis/core/config/app_config.dart';
import 'package:transitops_gis/core/config/app_environment.dart';
import 'package:transitops_gis/core/config/arcgis_config.dart';

void main() {
  test('maps AppConfig into ArcGISConfig without exposing a key when empty', () {
    const config = AppConfig(
      environment: AppEnvironment.development,
      apiBaseUrl: 'https://api.example.invalid/v1',
      arcgisApiKey: '',
      arcgisPortalUrl: 'https://www.arcgis.com',
    );

    final gis = ArcGISConfig.fromAppConfig(config);

    expect(gis.hasApiKey, isFalse);
    expect(gis.portalUrl, 'https://www.arcgis.com');
    expect(gis.environment, AppEnvironment.development);
    expect(gis.basemapStyleId, ArcGISBasemapStyleId.streets);
  });
}
