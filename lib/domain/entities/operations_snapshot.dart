import 'package:equatable/equatable.dart';

/// Fleet operations KPIs. Later phases can derive this from GIS feature queries.
class OperationsSnapshot extends Equatable {
  const OperationsSnapshot({
    required this.activeVehicles,
    required this.totalStops,
    required this.activeRoutes,
    required this.openIncidents,
    required this.sourceLabel,
  });

  final int activeVehicles;
  final int totalStops;
  final int activeRoutes;
  final int openIncidents;
  final String sourceLabel;

  bool get isEmpty =>
      activeVehicles == 0 &&
      totalStops == 0 &&
      activeRoutes == 0 &&
      openIncidents == 0;

  @override
  List<Object?> get props => [
    activeVehicles,
    totalStops,
    activeRoutes,
    openIncidents,
    sourceLabel,
  ];
}
