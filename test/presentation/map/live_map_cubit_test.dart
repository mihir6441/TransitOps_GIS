import 'package:flutter_test/flutter_test.dart';
import 'package:transitops_gis/core/config/arcgis_config.dart';
import 'package:transitops_gis/core/config/app_environment.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/core/error/result.dart';
import 'package:transitops_gis/core/gis/arcgis_runtime_service.dart';
import 'package:transitops_gis/core/utils/app_logger.dart';
import 'package:transitops_gis/data/gis/arcgis_map_factory.dart';
import 'package:transitops_gis/data/gis/arcgis_map_session.dart';
import 'package:transitops_gis/data/gis/arcgis_operational_layer_service.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/domain/usecases/get_gis_catalog.dart';
import 'package:transitops_gis/presentation/map/cubit/live_map_cubit.dart';
import 'package:transitops_gis/presentation/map/cubit/live_map_state.dart';

import '../../helpers/fake_arcgis_runtime_gateway.dart';
import '../../helpers/fake_gis_repository.dart';

void main() {
  const emptyCatalog = GisCatalog(
    vehicles: [],
    stops: [],
    routes: [],
    incidents: [],
  );

  LiveMapCubit buildCubit({required ArcGISConfig config}) {
    return LiveMapCubit(
      config: config,
      runtimeService: ArcGISRuntimeService(
        config: config,
        gateway: FakeArcGISRuntimeGateway(),
        logger: const AppLogger(),
      )..initialize(),
      getGisCatalog: GetGisCatalog(
        FakeGisRepository(const Success(emptyCatalog)),
      ),
      mapSession: ArcGISMapSession(
        ArcGISOperationalLayerService(),
        ArcGISMapFactory(config),
      ),
    );
  }

  test('reports missing API key when runtime is not initialized', () async {
    const config = ArcGISConfig(
      apiKey: '',
      portalUrl: 'https://www.arcgis.com',
      environment: AppEnvironment.development,
    );
    final cubit = buildCubit(config: config);

    expect(cubit.state.status, LiveMapStatus.missingApiKey);
    expect(cubit.state.message, AppStrings.arcgisApiKeyMissing);
    await cubit.close();
  });

  test('is ready after a configured runtime initialize', () async {
    const config = ArcGISConfig(
      apiKey: 'test-key',
      portalUrl: 'https://www.arcgis.com',
      environment: AppEnvironment.development,
    );
    final cubit = buildCubit(config: config);

    expect(cubit.state.status, LiveMapStatus.ready);
    expect(cubit.state.layerVisibility.values.every((visible) => visible), isTrue);
    await cubit.close();
  });
}
