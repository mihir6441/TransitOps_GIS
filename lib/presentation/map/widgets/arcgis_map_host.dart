import 'package:arcgis_maps/arcgis_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitops_gis/core/config/injection.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/data/gis/arcgis_map_factory.dart';
import 'package:transitops_gis/data/gis/arcgis_map_session.dart';
import 'package:transitops_gis/presentation/map/cubit/live_map_cubit.dart';
import 'package:transitops_gis/presentation/map/cubit/live_map_state.dart';
import 'package:transitops_gis/presentation/map/widgets/feature_info_card.dart';
import 'package:transitops_gis/presentation/map/widgets/layer_control_panel.dart';
import 'package:transitops_gis/presentation/map/widgets/map_control_button.dart';

/// Hosts Esri's native [ArcGISMapView].
///
/// The SDK requires [ArcGISMapView] to be a child of [Expanded] inside a
/// [Column] (not a [Stack]). Overlays sit in a sibling stack above that column.
class ArcGISMapHost extends StatefulWidget {
  const ArcGISMapHost({super.key});

  @override
  State<ArcGISMapHost> createState() => _ArcGISMapHostState();
}

class _ArcGISMapHostState extends State<ArcGISMapHost> {
  late final ArcGISMapViewController _controller;

  @override
  void initState() {
    super.initState();
    final factory = sl<ArcGISMapFactory>();
    _controller = factory.createController()
      ..arcGISMap = factory.createBasemapMap();
    sl<ArcGISMapSession>().bind(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LiveMapCubit>();
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Expanded(
              child: ArcGISMapView(
                controllerProvider: () => _controller,
                onMapViewReady: cubit.onMapViewReady,
                onTap: cubit.identifyAt,
              ),
            ),
          ],
        ),
        Positioned(
          right: 12,
          top: 12,
          child: Column(
            children: [
              MapControlButton(
                icon: Icons.add,
                tooltip: AppStrings.zoomIn,
                onPressed: cubit.zoomIn,
              ),
              const SizedBox(height: 8),
              MapControlButton(
                icon: Icons.remove,
                tooltip: AppStrings.zoomOut,
                onPressed: cubit.zoomOut,
              ),
              const SizedBox(height: 8),
              MapControlButton(
                icon: Icons.my_location,
                tooltip: AppStrings.recenter,
                onPressed: cubit.recenter,
              ),
              const SizedBox(height: 8),
              MapControlButton(
                icon: Icons.layers_outlined,
                tooltip: AppStrings.layers,
                onPressed: cubit.toggleLayerPanel,
              ),
            ],
          ),
        ),
        BlocBuilder<LiveMapCubit, LiveMapState>(
          buildWhen: (previous, current) =>
              previous.showLayerPanel != current.showLayerPanel,
          builder: (context, state) {
            if (!state.showLayerPanel) {
              return const SizedBox.shrink();
            }
            return const Positioned(
              right: 68,
              top: 12,
              width: 220,
              child: LayerControlPanel(),
            );
          },
        ),
        const Positioned(
          left: 12,
          bottom: 12,
          right: 80,
          child: _MapLegend(),
        ),
        BlocBuilder<LiveMapCubit, LiveMapState>(
          buildWhen: (previous, current) =>
              previous.selectedFeature != current.selectedFeature,
          builder: (context, state) {
            final feature = state.selectedFeature;
            if (feature == null) {
              return const SizedBox.shrink();
            }
            return Positioned(
              left: 12,
              right: 12,
              bottom: 56,
              child: FeatureInfoCard(
                feature: feature,
                onClose: cubit.clearSelection,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MapLegend extends StatelessWidget {
  const _MapLegend();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.94),
      elevation: 1,
      borderRadius: BorderRadius.circular(8),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Text(AppStrings.mapLegend),
      ),
    );
  }
}
