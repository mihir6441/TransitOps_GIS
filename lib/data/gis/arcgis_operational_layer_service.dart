import 'package:arcgis_maps/arcgis_maps.dart' hide Incident;
import 'package:transitops_gis/core/theme/app_colors.dart';
import 'package:transitops_gis/domain/entities/geo_coordinate.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/domain/entities/gis_enums.dart';
import 'package:transitops_gis/domain/entities/gis_features.dart';
import 'package:transitops_gis/domain/entities/selected_gis_feature.dart';

class ArcGISOperationalLayerService {
  Future<FeatureCollectionLayer> createOperationalLayer(GisCatalog catalog) async {
    final tables = [
      await _vehicleTable(catalog.vehicles),
      await _stopTable(catalog.stops),
      await _routeTable(catalog.routes),
      await _incidentTable(catalog.incidents),
    ];
    return FeatureCollectionLayer.withFeatureCollection(
      FeatureCollection.withTables(tables),
    );
  }

  void applyVisibility({
    required FeatureCollectionLayer layer,
    required Map<GisLayerType, bool> visibility,
  }) {
    const order = GisLayerType.values;
    final layers = layer.layers;
    for (var index = 0; index < layers.length && index < order.length; index++) {
      layers[index].isVisible = visibility[order[index]] ?? true;
    }
  }

  SelectedGisFeature? featureFromGeoElement(GeoElement element) {
    final attributes = <String, String>{};
    for (final entry in element.attributes.entries) {
      attributes[entry.key] = '${entry.value}';
    }
    final layerName = attributes['layerType'] ?? '';
    final type = GisLayerType.values.where((value) => value.name == layerName);
    if (type.isEmpty) {
      return null;
    }
    return SelectedGisFeature(
      layerType: type.first,
      id: attributes['id'] ?? '',
      title: attributes['title'] ?? attributes['id'] ?? 'Feature',
      fields: attributes,
    );
  }

  Future<FeatureCollectionTable> _vehicleTable(List<Vehicle> vehicles) async {
    final table = FeatureCollectionTable(
      fields: [
        Field.text(name: 'id', alias: 'ID', length: 32),
        Field.text(name: 'layerType', alias: 'Layer', length: 24),
        Field.text(name: 'title', alias: 'Title', length: 64),
        Field.text(name: 'vehicleNumber', alias: 'Vehicle', length: 32),
        Field.text(name: 'driverName', alias: 'Driver', length: 64),
        Field.text(name: 'status', alias: 'Status', length: 24),
        Field.double(name: 'speed', alias: 'Speed'),
        Field.text(name: 'routeId', alias: 'Route', length: 16),
      ],
      geometryType: GeometryType.point,
      spatialReference: SpatialReference.wgs84,
    )..displayName = GisLayerType.vehicles.name;
    table.renderer = SimpleRenderer(
      symbol: SimpleMarkerSymbol(
        style: SimpleMarkerSymbolStyle.circle,
        color: AppColors.teal,
        size: 12,
      ),
    );
    final features = [
      for (final vehicle in vehicles)
        table.createFeature(
          attributes: {
            'id': vehicle.id,
            'layerType': GisLayerType.vehicles.name,
            'title': vehicle.vehicleNumber,
            'vehicleNumber': vehicle.vehicleNumber,
            'driverName': vehicle.driverName,
            'status': vehicle.status.name,
            'speed': vehicle.speedKph,
            'routeId': vehicle.routeId,
          },
          geometry: _point(vehicle.coordinate),
        ),
    ];
    await table.addFeatures(features);
    return table;
  }

  Future<FeatureCollectionTable> _stopTable(List<TransitStop> stops) async {
    final table = FeatureCollectionTable(
      fields: [
        Field.text(name: 'id', alias: 'ID', length: 32),
        Field.text(name: 'layerType', alias: 'Layer', length: 24),
        Field.text(name: 'title', alias: 'Title', length: 64),
        Field.text(name: 'name', alias: 'Name', length: 64),
        Field.text(name: 'routeId', alias: 'Route', length: 16),
        Field.text(name: 'status', alias: 'Status', length: 24),
      ],
      geometryType: GeometryType.point,
      spatialReference: SpatialReference.wgs84,
    )..displayName = GisLayerType.stops.name;
    table.renderer = SimpleRenderer(
      symbol: SimpleMarkerSymbol(
        style: SimpleMarkerSymbolStyle.square,
        color: AppColors.navy,
        size: 10,
      ),
    );
    final features = [
      for (final stop in stops)
        table.createFeature(
          attributes: {
            'id': stop.id,
            'layerType': GisLayerType.stops.name,
            'title': stop.name,
            'name': stop.name,
            'routeId': stop.routeId,
            'status': stop.status.name,
          },
          geometry: _point(stop.coordinate),
        ),
    ];
    await table.addFeatures(features);
    return table;
  }

  Future<FeatureCollectionTable> _routeTable(List<TransitRoute> routes) async {
    final table = FeatureCollectionTable(
      fields: [
        Field.text(name: 'id', alias: 'ID', length: 32),
        Field.text(name: 'layerType', alias: 'Layer', length: 24),
        Field.text(name: 'title', alias: 'Title', length: 64),
        Field.text(name: 'routeNumber', alias: 'Number', length: 16),
        Field.text(name: 'name', alias: 'Name', length: 64),
        Field.text(name: 'status', alias: 'Status', length: 24),
        Field.double(name: 'distance', alias: 'Distance'),
      ],
      geometryType: GeometryType.polyline,
      spatialReference: SpatialReference.wgs84,
    )..displayName = GisLayerType.routes.name;
    table.renderer = SimpleRenderer(
      symbol: SimpleLineSymbol(
        style: SimpleLineSymbolStyle.solid,
        color: AppColors.tealLight,
        width: 3.5,
      ),
    );
    final features = [
      for (final route in routes)
        table.createFeature(
          attributes: {
            'id': route.id,
            'layerType': GisLayerType.routes.name,
            'title': '${route.routeNumber} ${route.name}',
            'routeNumber': route.routeNumber,
            'name': route.name,
            'status': route.status.name,
            'distance': route.distanceKm,
          },
          geometry: _polyline(route.path.vertices),
        ),
    ];
    await table.addFeatures(features);
    return table;
  }

  Future<FeatureCollectionTable> _incidentTable(List<Incident> incidents) async {
    final table = FeatureCollectionTable(
      fields: [
        Field.text(name: 'id', alias: 'ID', length: 32),
        Field.text(name: 'layerType', alias: 'Layer', length: 24),
        Field.text(name: 'title', alias: 'Title', length: 64),
        Field.text(name: 'type', alias: 'Type', length: 32),
        Field.text(name: 'severity', alias: 'Severity', length: 16),
        Field.text(name: 'description', alias: 'Description', length: 256),
        Field.text(name: 'status', alias: 'Status', length: 24),
      ],
      geometryType: GeometryType.point,
      spatialReference: SpatialReference.wgs84,
    )..displayName = GisLayerType.incidents.name;
    table.renderer = SimpleRenderer(
      symbol: SimpleMarkerSymbol(
        style: SimpleMarkerSymbolStyle.triangle,
        color: AppColors.danger,
        size: 14,
      ),
    );
    final features = [
      for (final incident in incidents)
        table.createFeature(
          attributes: {
            'id': incident.id,
            'layerType': GisLayerType.incidents.name,
            'title': incident.type.name,
            'type': incident.type.name,
            'severity': incident.severity.name,
            'description': incident.description,
            'status': incident.status.name,
          },
          geometry: _point(incident.coordinate),
        ),
    ];
    await table.addFeatures(features);
    return table;
  }

  ArcGISPoint _point(GeoCoordinate coordinate) {
    return ArcGISPoint(
      x: coordinate.longitude,
      y: coordinate.latitude,
      spatialReference: SpatialReference.wgs84,
    );
  }

  Polyline _polyline(List<GeoCoordinate> vertices) {
    final builder = PolylineBuilder(spatialReference: SpatialReference.wgs84);
    for (final vertex in vertices) {
      builder.addPointXY(x: vertex.longitude, y: vertex.latitude);
    }
    return builder.toGeometry() as Polyline;
  }
}
