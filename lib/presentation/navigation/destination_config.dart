import 'package:flutter/material.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/navigation/app_destination.dart';

class DestinationConfig {
  const DestinationConfig({
    required this.destination,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final AppDestination destination;
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  static const List<DestinationConfig> items = [
    DestinationConfig(
      destination: AppDestination.dashboard,
      label: AppStrings.dashboard,
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
    ),
    DestinationConfig(
      destination: AppDestination.liveMap,
      label: AppStrings.liveMap,
      icon: Icons.map_outlined,
      selectedIcon: Icons.map,
    ),
    DestinationConfig(
      destination: AppDestination.vehicles,
      label: AppStrings.vehicles,
      icon: Icons.directions_bus_outlined,
      selectedIcon: Icons.directions_bus,
    ),
    DestinationConfig(
      destination: AppDestination.routes,
      label: AppStrings.routes,
      icon: Icons.alt_route_outlined,
      selectedIcon: Icons.alt_route,
    ),
    DestinationConfig(
      destination: AppDestination.incidents,
      label: AppStrings.incidents,
      icon: Icons.report_outlined,
      selectedIcon: Icons.report,
    ),
    DestinationConfig(
      destination: AppDestination.settings,
      label: AppStrings.settings,
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
    ),
  ];
}
