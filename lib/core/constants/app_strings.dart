class AppStrings {
  AppStrings._();

  static const String appName = 'TransitOps GIS';
  static const String appSubtitle = 'Transportation & Field Operations';

  static const String dashboard = 'Dashboard';
  static const String liveMap = 'Live Map';
  static const String vehicles = 'Vehicles';
  static const String routes = 'Routes';
  static const String incidents = 'Incidents';
  static const String settings = 'Settings';
  static const String openLiveMap = 'Open Live Map';
  static const String activeVehicles = 'Active Vehicles';
  static const String totalStops = 'Stops';
  static const String activeRoutes = 'Active Routes';
  static const String openIncidents = 'Open Incidents';
  static const String layers = 'Layers';
  static const String zoomIn = 'Zoom in';
  static const String zoomOut = 'Zoom out';
  static const String recenter = 'Recenter';

  static const String dashboardEmpty =
      'No operational metrics are available right now.';

  static const String foundationNotice =
      'This module is scaffolded. Operational data and ArcGIS services will be connected in later phases.';

  static const String unexpectedError =
      'Something went wrong. Please try again.';
  static const String networkError =
      'Unable to reach the network. Check connectivity and retry.';
  static const String timeoutError = 'The request timed out. Please try again.';
  static const String arcgisApiKeyMissing =
      'An ArcGIS API key is required to load the live map. Copy dart_defines.example.json to dart_defines.json, paste your key, and run with --dart-define-from-file=dart_defines.json.';
  static const String mapLayersUnavailable =
      'Operational layers could not load. The streets basemap should still appear.';
  static const String mapLegend =
      'Austin operations · tap a vehicle, stop, route, or incident';

}
