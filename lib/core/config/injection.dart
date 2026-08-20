import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:transitops_gis/core/config/app_config.dart';
import 'package:transitops_gis/core/config/arcgis_config.dart';
import 'package:transitops_gis/core/gis/arcgis_runtime_gateway.dart';
import 'package:transitops_gis/core/gis/arcgis_runtime_gateway_impl.dart';
import 'package:transitops_gis/core/gis/arcgis_runtime_service.dart';
import 'package:transitops_gis/core/network/dio_client.dart';
import 'package:transitops_gis/core/network/network_info.dart';
import 'package:transitops_gis/core/utils/app_logger.dart';
import 'package:transitops_gis/data/datasources/gis_remote_data_source.dart';
import 'package:transitops_gis/data/datasources/mock_gis_data_source.dart';
import 'package:transitops_gis/data/gis/arcgis_map_factory.dart';
import 'package:transitops_gis/data/gis/arcgis_map_session.dart';
import 'package:transitops_gis/data/gis/arcgis_operational_layer_service.dart';
import 'package:transitops_gis/data/repositories/gis_repository_impl.dart';
import 'package:transitops_gis/data/repositories/operations_repository_impl.dart';
import 'package:transitops_gis/domain/repositories/gis_repository.dart';
import 'package:transitops_gis/domain/repositories/operations_repository.dart';
import 'package:transitops_gis/domain/usecases/get_gis_catalog.dart';
import 'package:transitops_gis/domain/usecases/get_operations_snapshot.dart';
import 'package:transitops_gis/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:transitops_gis/presentation/map/cubit/live_map_cubit.dart';
import 'package:transitops_gis/presentation/navigation/navigation_cubit.dart';
import 'package:transitops_gis/presentation/operations/cubit/gis_catalog_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies({
  AppConfig? config,
  ArcGISRuntimeGateway? runtimeGateway,
  OperationsRepository? operationsRepository,
  GisRepository? gisRepository,
}) async {
  if (sl.isRegistered<AppConfig>()) {
    await sl.reset();
  }

  sl.registerLazySingleton<AppConfig>(
    () => config ?? AppConfig.fromEnvironment(),
  );
  sl.registerLazySingleton<ArcGISConfig>(
    () => ArcGISConfig.fromAppConfig(sl<AppConfig>()),
  );
  sl.registerLazySingleton<AppLogger>(() => const AppLogger());
  sl.registerLazySingleton<NetworkInfo>(NetworkInfoImpl.new);
  sl.registerLazySingleton<Dio>(() => DioClient.create(sl<AppConfig>()));
  sl.registerLazySingleton<ArcGISRuntimeGateway>(
    () => runtimeGateway ?? ArcGISRuntimeGatewayImpl(),
  );
  sl.registerLazySingleton<ArcGISRuntimeService>(
    () => ArcGISRuntimeService(
      config: sl<ArcGISConfig>(),
      gateway: sl<ArcGISRuntimeGateway>(),
      logger: sl<AppLogger>(),
    ),
  );
  sl.registerLazySingleton<ArcGISMapFactory>(
    () => ArcGISMapFactory(sl<ArcGISConfig>()),
  );
  sl.registerLazySingleton<GisRemoteDataSource>(MockGisDataSource.new);
  sl.registerLazySingleton<GisRepository>(
    () => gisRepository ?? GisRepositoryImpl(sl<GisRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetGisCatalog>(
    () => GetGisCatalog(sl<GisRepository>()),
  );
  sl.registerLazySingleton<OperationsRepository>(
    () =>
        operationsRepository ??
        OperationsRepositoryImpl(sl<GisRepository>()),
  );
  sl.registerLazySingleton<GetOperationsSnapshot>(
    () => GetOperationsSnapshot(sl<OperationsRepository>()),
  );
  sl.registerLazySingleton<ArcGISOperationalLayerService>(
    ArcGISOperationalLayerService.new,
  );
  sl.registerLazySingleton<ArcGISMapSession>(
    () => ArcGISMapSession(
      sl<ArcGISOperationalLayerService>(),
      sl<ArcGISMapFactory>(),
    ),
  );
  sl.registerFactory<NavigationCubit>(NavigationCubit.new);
  sl.registerFactory<DashboardCubit>(
    () => DashboardCubit(sl<GetOperationsSnapshot>()),
  );
  sl.registerFactory<GisCatalogCubit>(
    () => GisCatalogCubit(sl<GetGisCatalog>()),
  );
  sl.registerFactory<LiveMapCubit>(
    () => LiveMapCubit(
      config: sl<ArcGISConfig>(),
      runtimeService: sl<ArcGISRuntimeService>(),
      getGisCatalog: sl<GetGisCatalog>(),
      mapSession: sl<ArcGISMapSession>(),
    ),
  );
}
