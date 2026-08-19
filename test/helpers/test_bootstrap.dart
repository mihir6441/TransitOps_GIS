import 'package:transitops_gis/core/config/app_config.dart';
import 'package:transitops_gis/core/config/app_environment.dart';
import 'package:transitops_gis/core/config/injection.dart';

Future<void> setUpTestDependencies({AppConfig? config}) async {
  await configureDependencies(
    config:
        config ??
        const AppConfig(
          environment: AppEnvironment.development,
          apiBaseUrl: 'https://api.example.invalid/v1',
          arcgisApiKey: '',
          arcgisPortalUrl: 'https://www.arcgis.com',
        ),
  );
}

Future<void> tearDownTestDependencies() async {
  await sl.reset();
}
