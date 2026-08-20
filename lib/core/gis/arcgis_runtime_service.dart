import 'package:transitops_gis/core/config/arcgis_config.dart';
import 'package:transitops_gis/core/gis/arcgis_runtime_gateway.dart';
import 'package:transitops_gis/core/utils/app_logger.dart';

class ArcGISRuntimeService {
  ArcGISRuntimeService({
    required ArcGISConfig config,
    required ArcGISRuntimeGateway gateway,
    required AppLogger logger,
  }) : _config = config,
       _gateway = gateway,
       _logger = logger;

  final ArcGISConfig _config;
  final ArcGISRuntimeGateway _gateway;
  final AppLogger _logger;

  bool initialize() {
    if (!_config.hasApiKey) {
      _logger.info(
        'ArcGIS API key is not configured. Pass ARCGIS_API_KEY via dart-define.',
      );
      return false;
    }

    _gateway.applyApiKey(_config.apiKey);
    _logger.info(
      'ArcGIS runtime initialized for ${_config.environment.name} '
      '(portal: ${_config.portalUrl}).',
    );
    return true;
  }

  bool get isReady => _gateway.isApiKeyApplied;
}
