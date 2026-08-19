class AppConstants {
  AppConstants._();

  static const String appName = 'TransitOps GIS';
  static const String appSubtitle = 'Transportation & Field Operations';

  static const Duration networkTimeout = Duration(seconds: 20);
  static const Duration locationTimeout = Duration(seconds: 10);

  /// Default nearby-vehicle search radius. Used by later GIS phases.
  static const double defaultNearbyRadiusKm = 5;
}
