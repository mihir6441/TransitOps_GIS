import 'package:transitops_gis/core/location/device_location.dart';

/// Device location contract. Concrete providers are added in Phase 5 so
/// UI never talks to the platform location APIs directly.
abstract class LocationService {
  Future<bool> hasPermission();

  Future<bool> requestPermission();

  Future<DeviceLocation> getCurrentLocation();

  Stream<DeviceLocation> watchLocation();
}
