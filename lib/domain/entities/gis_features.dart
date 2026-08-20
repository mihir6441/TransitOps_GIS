import 'package:equatable/equatable.dart';
import 'package:transitops_gis/domain/entities/geo_coordinate.dart';
import 'package:transitops_gis/domain/entities/gis_enums.dart';

class Vehicle extends Equatable {
  const Vehicle({
    required this.id,
    required this.vehicleNumber,
    required this.driverName,
    required this.status,
    required this.speedKph,
    required this.routeId,
    required this.coordinate,
    required this.lastUpdated,
  });

  final String id;
  final String vehicleNumber;
  final String driverName;
  final VehicleStatus status;
  final double speedKph;
  final String routeId;
  final GeoCoordinate coordinate;
  final DateTime lastUpdated;

  @override
  List<Object?> get props => [
    id,
    vehicleNumber,
    driverName,
    status,
    speedKph,
    routeId,
    coordinate,
    lastUpdated,
  ];
}

class TransitStop extends Equatable {
  const TransitStop({
    required this.id,
    required this.name,
    required this.routeId,
    required this.status,
    required this.coordinate,
  });

  final String id;
  final String name;
  final String routeId;
  final StopStatus status;
  final GeoCoordinate coordinate;

  @override
  List<Object?> get props => [id, name, routeId, status, coordinate];
}

class TransitRoute extends Equatable {
  const TransitRoute({
    required this.id,
    required this.routeNumber,
    required this.name,
    required this.status,
    required this.startLocation,
    required this.destination,
    required this.distanceKm,
    required this.path,
  });

  final String id;
  final String routeNumber;
  final String name;
  final RouteStatus status;
  final String startLocation;
  final String destination;
  final double distanceKm;
  final GeoPath path;

  @override
  List<Object?> get props => [
    id,
    routeNumber,
    name,
    status,
    startLocation,
    destination,
    distanceKm,
    path,
  ];
}

class Incident extends Equatable {
  const Incident({
    required this.id,
    required this.type,
    required this.severity,
    required this.description,
    required this.coordinate,
    required this.createdAt,
    required this.status,
  });

  final String id;
  final IncidentType type;
  final IncidentSeverity severity;
  final String description;
  final GeoCoordinate coordinate;
  final DateTime createdAt;
  final IncidentStatus status;

  @override
  List<Object?> get props => [
    id,
    type,
    severity,
    description,
    coordinate,
    createdAt,
    status,
  ];
}
