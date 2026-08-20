import 'package:transitops_gis/core/config/app_config.dart';
import 'package:transitops_gis/core/config/app_environment.dart';
import 'package:transitops_gis/core/config/injection.dart';
import 'package:transitops_gis/core/gis/arcgis_runtime_gateway.dart';
import 'package:transitops_gis/domain/repositories/operations_repository.dart';

import 'fake_arcgis_runtime_gateway.dart';

Future<void> setUpTestDependencies({
  AppConfig? config,
  ArcGISRuntimeGateway? runtimeGateway,
  OperationsRepository? operationsRepository,
}) async {
  await configureDependencies(
    config:
        config ??
        const AppConfig(
          environment: AppEnvironment.development,
          apiBaseUrl: 'https://api.example.invalid/v1',
          arcgisApiKey: '',
          arcgisPortalUrl: 'https://www.arcgis.com',
        ),
    runtimeGateway: runtimeGateway ?? FakeArcGISRuntimeGateway(),
    operationsRepository: operationsRepository,
  );
}

Future<void> tearDownTestDependencies() async {
  await sl.reset();
}
