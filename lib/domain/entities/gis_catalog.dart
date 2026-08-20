import 'package:equatable/equatable.dart';
import 'package:transitops_gis/domain/entities/gis_enums.dart';
import 'package:transitops_gis/domain/entities/gis_features.dart';

class GisCatalog extends Equatable {
  const GisCatalog({
    required this.vehicles,
    required this.stops,
    required this.routes,
    required this.incidents,
  });

  final List<Vehicle> vehicles;
  final List<TransitStop> stops;
  final List<TransitRoute> routes;
  final List<Incident> incidents;

  int get activeVehicleCount =>
      vehicles.where((vehicle) => vehicle.status == VehicleStatus.active).length;

  int get activeRouteCount =>
      routes.where((route) => route.status == RouteStatus.active).length;

  int get openIncidentCount => incidents
      .where((incident) => incident.status != IncidentStatus.resolved)
      .length;

  @override
  List<Object?> get props => [vehicles, stops, routes, incidents];
}
