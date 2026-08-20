import 'package:flutter_test/flutter_test.dart';
import 'package:transitops_gis/core/config/arcgis_config.dart';
import 'package:transitops_gis/core/config/app_environment.dart';
import 'package:transitops_gis/core/gis/arcgis_runtime_service.dart';
import 'package:transitops_gis/core/utils/app_logger.dart';

import '../../helpers/fake_arcgis_runtime_gateway.dart';

void main() {
  test('does not apply an empty API key', () {
    final gateway = FakeArcGISRuntimeGateway();
    final service = ArcGISRuntimeService(
      config: const ArcGISConfig(
        apiKey: '',
        portalUrl: 'https://www.arcgis.com',
        environment: AppEnvironment.development,
      ),
      gateway: gateway,
      logger: const AppLogger(),
    );

    expect(service.initialize(), isFalse);
    expect(gateway.appliedKey, isNull);
    expect(service.isReady, isFalse);
  });

  test('applies a provided API key through the gateway', () {
    final gateway = FakeArcGISRuntimeGateway();
    final service = ArcGISRuntimeService(
      config: const ArcGISConfig(
        apiKey: 'test-key',
        portalUrl: 'https://www.arcgis.com',
        environment: AppEnvironment.development,
      ),
      gateway: gateway,
      logger: const AppLogger(),
    );

    expect(service.initialize(), isTrue);
    expect(gateway.appliedKey, 'test-key');
    expect(service.isReady, isTrue);
  });
}
