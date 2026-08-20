import 'package:arcgis_maps/arcgis_maps.dart';
import 'package:transitops_gis/core/gis/arcgis_runtime_gateway.dart';

class ArcGISRuntimeGatewayImpl implements ArcGISRuntimeGateway {
  bool _applied = false;

  @override
  void applyApiKey(String apiKey) {
    ArcGISEnvironment.apiKey = apiKey;
    _applied = apiKey.isNotEmpty;
  }

  @override
  bool get isApiKeyApplied => _applied;
}
