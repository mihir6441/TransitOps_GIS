import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitops_gis/core/config/injection.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/core/responsive/responsive.dart';
import 'package:transitops_gis/domain/entities/operations_snapshot.dart';
import 'package:transitops_gis/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:transitops_gis/presentation/dashboard/cubit/dashboard_state.dart';
import 'package:transitops_gis/presentation/navigation/app_destination.dart';
import 'package:transitops_gis/presentation/navigation/navigation_cubit.dart';
import 'package:transitops_gis/presentation/shared/widgets/empty_state.dart';
import 'package:transitops_gis/presentation/shared/widgets/error_state.dart';
import 'package:transitops_gis/presentation/shared/widgets/loading_state.dart';
import 'package:transitops_gis/presentation/shared/widgets/metric_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DashboardCubit>(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return switch (state.status) {
          DashboardStatus.loading => const LoadingState(
            message: 'Loading operations summary',
          ),
          DashboardStatus.empty => const EmptyState(
            icon: Icons.dashboard_outlined,
            title: AppStrings.dashboard,
            message: AppStrings.dashboardEmpty,
          ),
          DashboardStatus.error => ErrorState(
            message: state.message ?? AppStrings.unexpectedError,
            onRetry: () => context.read<DashboardCubit>().load(),
          ),
          DashboardStatus.loaded => _DashboardContent(
            snapshot: state.snapshot!,
          ),
        };
      },
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.snapshot});

  final OperationsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final columns = Responsive.dashboardMetricColumns(context);
    final metrics = [
      (
        label: AppStrings.activeVehicles,
        value: '${snapshot.activeVehicles}',
        icon: Icons.directions_bus_outlined,
      ),
      (
        label: AppStrings.totalStops,
        value: '${snapshot.totalStops}',
        icon: Icons.place_outlined,
      ),
      (
        label: AppStrings.activeRoutes,
        value: '${snapshot.activeRoutes}',
        icon: Icons.alt_route_outlined,
      ),
      (
        label: AppStrings.openIncidents,
        value: '${snapshot.openIncidents}',
        icon: Icons.report_outlined,
      ),
    ];

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.appName,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.appSubtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: columns == 1 ? 128 : 148,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final metric = metrics[index];
                return MetricCard(
                  label: metric.label,
                  value: metric.value,
                  icon: metric.icon,
                );
              },
              childCount: metrics.length,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    context.read<NavigationCubit>().select(
                      AppDestination.liveMap,
                    );
                  },
                  icon: const Icon(Icons.map_outlined),
                  label: const Text(AppStrings.openLiveMap),
                ),
                const SizedBox(height: 12),
                Text(
                  snapshot.sourceLabel,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
