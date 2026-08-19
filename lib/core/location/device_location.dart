import 'package:equatable/equatable.dart';

class DeviceLocation extends Equatable {
  const DeviceLocation({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.accuracyMeters,
  });

  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final double? accuracyMeters;

  @override
  List<Object?> get props => [latitude, longitude, timestamp, accuracyMeters];
}
