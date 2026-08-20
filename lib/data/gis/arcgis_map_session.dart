import 'package:arcgis_maps/arcgis_maps.dart';
import 'package:flutter/material.dart';
import 'package:transitops_gis/data/datasources/mock_gis_data_source.dart';
import 'package:transitops_gis/data/gis/arcgis_map_factory.dart';
import 'package:transitops_gis/data/gis/arcgis_operational_layer_service.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/domain/entities/gis_enums.dart';
import 'package:transitops_gis/domain/entities/selected_gis_feature.dart';

class ArcGISMapSession {
  ArcGISMapSession(this._layerService, [this._mapFactory]);

  final ArcGISOperationalLayerService _layerService;
  final ArcGISMapFactory? _mapFactory;

  ArcGISMapViewController? _controller;
  FeatureCollectionLayer? _operationalLayer;

  void bind(ArcGISMapViewController controller) {
    if (!identical(_controller, controller)) {
      _operationalLayer = null;
    }
    _controller = controller;
  }

  Future<void> attachBasemap() async {
    final controller = _controller;
    final factory = _mapFactory;
    if (controller == null || factory == null) {
      return;
    }
    controller.arcGISMap ??= factory.createBasemapMap();
    final map = controller.arcGISMap;
    if (map != null) {
      await map.load();
    }
    await recenter();
  }

  Future<void> loadOperationalLayers(GisCatalog catalog) async {
    final controller = _controller;
    if (controller == null) {
      return;
    }

    if (_operationalLayer != null) {
      return;
    }

    final layer = await _layerService.createOperationalLayer(catalog);
    final layers = controller.arcGISMap?.operationalLayers;
    if (layers == null) {
      return;
    }
    layers.add(layer);
    await layer.load();
    _operationalLayer = layer;
  }

  void setLayerVisibility(Map<GisLayerType, bool> visibility) {
    final layer = _operationalLayer;
    if (layer == null) {
      return;
    }
    _layerService.applyVisibility(layer: layer, visibility: visibility);
  }

  Future<void> zoomIn() async {
    final controller = _controller;
    if (controller == null) {
      return;
    }
    final scale = controller.scale;
    final current = scale.isNaN ? MockGisDataSource.initialMapScale : scale;
    await controller.setViewpointScale(current * 0.5);
  }

  Future<void> zoomOut() async {
    final controller = _controller;
    if (controller == null) {
      return;
    }
    final scale = controller.scale;
    final current = scale.isNaN ? MockGisDataSource.initialMapScale : scale;
    await controller.setViewpointScale(current * 2);
  }

  Future<void> recenter() async {
    final controller = _controller;
    if (controller == null) {
      return;
    }
    await controller.setViewpointCenter(
      ArcGISPoint(
        x: MockGisDataSource.operationsCenter.longitude,
        y: MockGisDataSource.operationsCenter.latitude,
        spatialReference: SpatialReference.wgs84,
      ),
      scale: MockGisDataSource.initialMapScale,
    );
  }

  Future<SelectedGisFeature?> identify(Offset screenPoint) async {
    final controller = _controller;
    if (controller == null) {
      return null;
    }
    final results = await controller.identifyLayers(
      screenPoint: screenPoint,
      tolerance: 22,
      maximumResultsPerLayer: 1,
    );
    for (final result in _flattenIdentifyResults(results)) {
      for (final element in result.geoElements) {
        final feature = _layerService.featureFromGeoElement(element);
        if (feature != null) {
          return feature;
        }
      }
    }
    return null;
  }

  Iterable<IdentifyLayerResult> _flattenIdentifyResults(
    List<IdentifyLayerResult> results,
  ) sync* {
    for (final result in results) {
      yield result;
      yield* _flattenIdentifyResults(result.sublayerResults);
    }
  }
}
