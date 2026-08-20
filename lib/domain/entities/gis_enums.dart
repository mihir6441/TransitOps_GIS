enum VehicleStatus { active, idle, offline, maintenance }

enum StopStatus { inService, closed }

enum RouteStatus { active, suspended }

enum IncidentType {
  roadBlockage,
  accident,
  vehicleBreakdown,
  traffic,
  other,
}

enum IncidentSeverity { low, medium, high, critical }

enum IncidentStatus { open, inProgress, resolved }

enum GisLayerType { vehicles, stops, routes, incidents }
