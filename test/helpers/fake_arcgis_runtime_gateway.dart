import 'package:transitops_gis/core/gis/arcgis_runtime_gateway.dart';

class FakeArcGISRuntimeGateway implements ArcGISRuntimeGateway {
  String? appliedKey;

  @override
  void applyApiKey(String apiKey) {
    appliedKey = apiKey;
  }

  @override
  bool get isApiKeyApplied => appliedKey != null && appliedKey!.isNotEmpty;
}
