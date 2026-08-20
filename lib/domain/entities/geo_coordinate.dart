import 'package:equatable/equatable.dart';

class GeoCoordinate extends Equatable {
  const GeoCoordinate({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}

class GeoPath extends Equatable {
  const GeoPath(this.vertices);

  final List<GeoCoordinate> vertices;

  @override
  List<Object?> get props => [vertices];
}
