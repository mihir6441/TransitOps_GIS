import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:transitops_gis/core/config/app_config.dart';
import 'package:transitops_gis/core/network/dio_client.dart';
import 'package:transitops_gis/core/network/network_info.dart';
import 'package:transitops_gis/core/utils/app_logger.dart';
import 'package:transitops_gis/presentation/navigation/navigation_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies({AppConfig? config}) async {
  if (sl.isRegistered<AppConfig>()) {
    await sl.reset();
  }

  sl.registerLazySingleton<AppConfig>(
    () => config ?? AppConfig.fromEnvironment(),
  );
  sl.registerLazySingleton<AppLogger>(() => const AppLogger());
  sl.registerLazySingleton<NetworkInfo>(NetworkInfoImpl.new);
  sl.registerLazySingleton<Dio>(() => DioClient.create(sl<AppConfig>()));
  sl.registerFactory<NavigationCubit>(NavigationCubit.new);
}
