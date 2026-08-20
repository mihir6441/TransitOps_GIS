import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitops_gis/core/config/arcgis_config.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/core/gis/arcgis_runtime_service.dart';
import 'package:transitops_gis/data/gis/arcgis_map_session.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/domain/entities/gis_enums.dart';
import 'package:transitops_gis/domain/usecases/get_gis_catalog.dart';
import 'package:transitops_gis/domain/usecases/use_case.dart';
import 'package:transitops_gis/presentation/map/cubit/live_map_state.dart';

class LiveMapCubit extends Cubit<LiveMapState> {
  LiveMapCubit({
    required ArcGISConfig config,
    required ArcGISRuntimeService runtimeService,
    required GetGisCatalog getGisCatalog,
    required ArcGISMapSession mapSession,
  }) : _config = config,
       _runtimeService = runtimeService,
       _getGisCatalog = getGisCatalog,
       _mapSession = mapSession,
       super(const LiveMapState(status: LiveMapStatus.missingApiKey)) {
    hydrate();
  }

  final ArcGISConfig _config;
  final ArcGISRuntimeService _runtimeService;
  final GetGisCatalog _getGisCatalog;
  final ArcGISMapSession _mapSession;
  GisCatalog? _catalog;
  var _mapViewReady = false;

  Future<void> hydrate() async {
    if (!_config.hasApiKey || !_runtimeService.isReady) {
      emit(
        const LiveMapState(
          status: LiveMapStatus.missingApiKey,
          message: AppStrings.arcgisApiKeyMissing,
        ),
      );
      return;
    }

    emit(const LiveMapState(status: LiveMapStatus.ready));
    final result = await _getGisCatalog(const NoParams());
    result.fold(
      onSuccess: (catalog) {
        _catalog = catalog;
      },
      onFailure: (failure) {
        emit(
          LiveMapState(
            status: LiveMapStatus.error,
            message: failure.message,
          ),
        );
      },
    );
    await _loadLayersIfReady();
  }

  Future<void> onMapViewReady() async {
    _mapViewReady = true;
    try {
      await _mapSession.attachBasemap();
    } catch (_) {
      // Basemap tile failures should not crash the Live Map chrome.
    }
    await _loadLayersIfReady();
  }

  Future<void> _loadLayersIfReady() async {
    final catalog = _catalog;
    if (!_mapViewReady || catalog == null) {
      return;
    }
    try {
      await _mapSession.loadOperationalLayers(catalog);
      _mapSession.setLayerVisibility(state.layerVisibility);
    } catch (_) {
      emit(state.copyWith(message: AppStrings.mapLayersUnavailable));
    }
  }

  Future<void> zoomIn() => _mapSession.zoomIn();

  Future<void> zoomOut() => _mapSession.zoomOut();

  Future<void> recenter() => _mapSession.recenter();

  void toggleLayerPanel() {
    emit(state.copyWith(showLayerPanel: !state.showLayerPanel));
  }

  void setLayerVisible(GisLayerType type, bool visible) {
    final next = Map<GisLayerType, bool>.from(state.layerVisibility)
      ..[type] = visible;
    emit(state.copyWith(layerVisibility: next));
    _mapSession.setLayerVisibility(next);
  }

  Future<void> identifyAt(Offset screenPoint) async {
    final feature = await _mapSession.identify(screenPoint);
    emit(state.copyWith(selectedFeature: feature, clearSelection: feature == null));
  }

  void clearSelection() {
    emit(state.copyWith(clearSelection: true));
  }
}
