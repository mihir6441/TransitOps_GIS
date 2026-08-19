import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/core/responsive/responsive.dart';
import 'package:transitops_gis/presentation/dashboard/pages/dashboard_page.dart';
import 'package:transitops_gis/presentation/incidents/pages/incidents_page.dart';
import 'package:transitops_gis/presentation/map/pages/live_map_page.dart';
import 'package:transitops_gis/presentation/navigation/app_destination.dart';
import 'package:transitops_gis/presentation/navigation/destination_config.dart';
import 'package:transitops_gis/presentation/navigation/navigation_cubit.dart';
import 'package:transitops_gis/presentation/routes/pages/routes_page.dart';
import 'package:transitops_gis/presentation/settings/pages/settings_page.dart';
import 'package:transitops_gis/presentation/vehicles/pages/vehicles_page.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  static const _pages = <AppDestination, Widget>{
    AppDestination.dashboard: DashboardPage(),
    AppDestination.liveMap: LiveMapPage(),
    AppDestination.vehicles: VehiclesPage(),
    AppDestination.routes: RoutesPage(),
    AppDestination.incidents: IncidentsPage(),
    AppDestination.settings: SettingsPage(),
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, AppDestination>(
      builder: (context, destination) {
        final selectedIndex = DestinationConfig.items.indexWhere(
          (item) => item.destination == destination,
        );
        final index = selectedIndex < 0 ? 0 : selectedIndex;
        final isWide = Responsive.isWide(context);
        final body = IndexedStack(
          index: index,
          children: DestinationConfig.items
              .map((item) => _pages[item.destination]!)
              .toList(growable: false),
        );

        if (isWide) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  extended: MediaQuery.sizeOf(context).width >= 1100,
                  selectedIndex: index,
                  onDestinationSelected: (value) {
                    context.read<NavigationCubit>().select(
                      DestinationConfig.items[value].destination,
                    );
                  },
                  leading: const Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 24),
                    child: _BrandHeader(compact: false),
                  ),
                  labelType: MediaQuery.sizeOf(context).width >= 1100
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  destinations: [
                    for (final item in DestinationConfig.items)
                      NavigationRailDestination(
                        icon: Icon(item.icon),
                        selectedIcon: Icon(item.selectedIcon),
                        label: Text(item.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: body),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const _BrandHeader(compact: true),
          ),
          body: body,
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (value) {
              context.read<NavigationCubit>().select(
                DestinationConfig.items[value].destination,
              );
            },
            destinations: [
              for (final item in DestinationConfig.items)
                NavigationDestination(
                  icon: Icon(item.icon),
                  selectedIcon: Icon(item.selectedIcon),
                  label: item.label,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final onDark = compact || Theme.of(context).brightness == Brightness.dark;
    final titleColor = compact ? Colors.white : Colors.white;
    final subtitleColor = Colors.white.withValues(alpha: 0.72);

    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.appName,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          Text(
            AppStrings.appSubtitle,
            style: TextStyle(color: subtitleColor, fontSize: 11),
          ),
        ],
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.appName,
            style: TextStyle(
              color: onDark ? Colors.white : titleColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          Text(
            AppStrings.appSubtitle,
            style: TextStyle(color: subtitleColor, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
