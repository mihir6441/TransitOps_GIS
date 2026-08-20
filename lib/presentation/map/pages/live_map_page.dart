import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitops_gis/core/config/injection.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/map/cubit/live_map_cubit.dart';
import 'package:transitops_gis/presentation/map/cubit/live_map_state.dart';
import 'package:transitops_gis/presentation/map/widgets/arcgis_map_host.dart';
import 'package:transitops_gis/presentation/shared/widgets/empty_state.dart';
import 'package:transitops_gis/presentation/shared/widgets/error_state.dart';

class LiveMapPage extends StatelessWidget {
  const LiveMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LiveMapCubit>(),
      child: const _LiveMapView(),
    );
  }
}

class _LiveMapView extends StatelessWidget {
  const _LiveMapView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveMapCubit, LiveMapState>(
      builder: (context, state) {
        return switch (state.status) {
          LiveMapStatus.missingApiKey => EmptyState(
            icon: Icons.vpn_key_outlined,
            title: AppStrings.liveMap,
            message: state.message ?? AppStrings.arcgisApiKeyMissing,
          ),
          LiveMapStatus.error => ErrorState(
            message: state.message ?? AppStrings.unexpectedError,
            onRetry: () => context.read<LiveMapCubit>().hydrate(),
          ),
          LiveMapStatus.ready => const ArcGISMapHost(),
        };
      },
    );
  }
}
