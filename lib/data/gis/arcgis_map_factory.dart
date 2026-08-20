import 'package:arcgis_maps/arcgis_maps.dart';
import 'package:transitops_gis/core/config/arcgis_config.dart';
import 'package:transitops_gis/data/datasources/mock_gis_data_source.dart';

/// Builds ArcGIS map objects. Widgets consume the controller, not SDK constructors.
class ArcGISMapFactory {
  const ArcGISMapFactory(this._config);

  final ArcGISConfig _config;

  ArcGISMap createBasemapMap() {
    final map = ArcGISMap.withBasemapStyle(_basemapStyle());
    map.initialViewpoint = Viewpoint.fromCenter(
      ArcGISPoint(
        x: MockGisDataSource.operationsCenter.longitude,
        y: MockGisDataSource.operationsCenter.latitude,
        spatialReference: SpatialReference.wgs84,
      ),
      scale: MockGisDataSource.initialMapScale,
    );
    return map;
  }

  ArcGISMapViewController createController() {
    return ArcGISMapView.createController();
  }

  BasemapStyle _basemapStyle() {
    return switch (_config.basemapStyleId) {
      ArcGISBasemapStyleId.streets => BasemapStyle.arcGISStreets,
      ArcGISBasemapStyleId.navigation => BasemapStyle.arcGISNavigation,
      ArcGISBasemapStyleId.lightGray => BasemapStyle.arcGISLightGray,
      ArcGISBasemapStyleId.imagery => BasemapStyle.arcGISImagery,
    };
  }
}
