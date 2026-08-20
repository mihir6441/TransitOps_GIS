import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/domain/entities/gis_enums.dart';
import 'package:transitops_gis/presentation/map/cubit/live_map_cubit.dart';
import 'package:transitops_gis/presentation/map/cubit/live_map_state.dart';
import 'package:transitops_gis/presentation/shared/widgets/app_card.dart';

class LayerControlPanel extends StatelessWidget {
  const LayerControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveMapCubit, LiveMapState>(
      builder: (context, state) {
        return AppCard(
          padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 8, 8),
                child: Text(
                  AppStrings.layers,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              for (final type in GisLayerType.values)
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(_label(type)),
                  value: state.layerVisibility[type] ?? true,
                  onChanged: (value) {
                    context.read<LiveMapCubit>().setLayerVisible(type, value);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  String _label(GisLayerType type) {
    return switch (type) {
      GisLayerType.vehicles => AppStrings.vehicles,
      GisLayerType.stops => AppStrings.totalStops,
      GisLayerType.routes => AppStrings.routes,
      GisLayerType.incidents => AppStrings.incidents,
    };
  }
}
