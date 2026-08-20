import 'package:equatable/equatable.dart';
import 'package:transitops_gis/domain/entities/gis_enums.dart';
import 'package:transitops_gis/domain/entities/selected_gis_feature.dart';

enum LiveMapStatus { missingApiKey, ready, error }

class LiveMapState extends Equatable {
  const LiveMapState({
    required this.status,
    this.message,
    this.layerVisibility = const {
      GisLayerType.vehicles: true,
      GisLayerType.stops: true,
      GisLayerType.routes: true,
      GisLayerType.incidents: true,
    },
    this.selectedFeature,
    this.showLayerPanel = false,
  });

  final LiveMapStatus status;
  final String? message;
  final Map<GisLayerType, bool> layerVisibility;
  final SelectedGisFeature? selectedFeature;
  final bool showLayerPanel;

  bool get canShowMap => status == LiveMapStatus.ready;

  LiveMapState copyWith({
    LiveMapStatus? status,
    String? message,
    Map<GisLayerType, bool>? layerVisibility,
    SelectedGisFeature? selectedFeature,
    bool clearSelection = false,
    bool? showLayerPanel,
  }) {
    return LiveMapState(
      status: status ?? this.status,
      message: message ?? this.message,
      layerVisibility: layerVisibility ?? this.layerVisibility,
      selectedFeature: clearSelection
          ? null
          : selectedFeature ?? this.selectedFeature,
      showLayerPanel: showLayerPanel ?? this.showLayerPanel,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    layerVisibility,
    selectedFeature,
    showLayerPanel,
  ];
}
