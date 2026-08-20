import 'package:transitops_gis/data/datasources/gis_remote_data_source.dart';
import 'package:transitops_gis/domain/entities/geo_coordinate.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/domain/entities/gis_enums.dart';
import 'package:transitops_gis/domain/entities/gis_features.dart';

/// In-memory GIS catalog. Replace with ArcGISFeatureServiceDataSource later.
class MockGisDataSource implements GisRemoteDataSource {
  const MockGisDataSource();

  static const GeoCoordinate operationsCenter = GeoCoordinate(
    latitude: 30.2672,
    longitude: -97.7431,
  );

  static const double initialMapScale = 45000;

  @override
  Future<GisCatalog> fetchCatalog() async {
    final updated = DateTime.utc(2026, 8, 19, 14, 42);

    final routes = [
      TransitRoute(
        id: 'R-101',
        routeNumber: 'R-101',
        name: 'Congress Corridor',
        status: RouteStatus.active,
        startLocation: 'Republic Square',
        destination: 'Capitol Complex',
        distanceKm: 4.2,
        path: GeoPath([
          GeoCoordinate(latitude: 30.2648, longitude: -97.7469),
          GeoCoordinate(latitude: 30.2672, longitude: -97.7431),
          GeoCoordinate(latitude: 30.2728, longitude: -97.7410),
        ]),
      ),
      TransitRoute(
        id: 'R-102',
        routeNumber: 'R-102',
        name: 'Sixth Street Connector',
        status: RouteStatus.active,
        startLocation: 'Seaholm',
        destination: 'Convention Center',
        distanceKm: 3.6,
        path: GeoPath([
          GeoCoordinate(latitude: 30.2678, longitude: -97.7530),
          GeoCoordinate(latitude: 30.2674, longitude: -97.7431),
          GeoCoordinate(latitude: 30.2668, longitude: -97.7338),
        ]),
      ),
      TransitRoute(
        id: 'R-103',
        routeNumber: 'R-103',
        name: 'Riverside Express',
        status: RouteStatus.active,
        startLocation: 'Auditorium Shores',
        destination: 'Rainey District',
        distanceKm: 5.1,
        path: GeoPath([
          GeoCoordinate(latitude: 30.2615, longitude: -97.7512),
          GeoCoordinate(latitude: 30.2624, longitude: -97.7436),
          GeoCoordinate(latitude: 30.2638, longitude: -97.7352),
        ]),
      ),
    ];

    final stops = [
      TransitStop(
        id: 'S-01',
        name: 'Republic Square',
        routeId: 'R-101',
        status: StopStatus.inService,
        coordinate: GeoCoordinate(latitude: 30.2648, longitude: -97.7469),
      ),
      TransitStop(
        id: 'S-02',
        name: 'Downtown Transit Hub',
        routeId: 'R-101',
        status: StopStatus.inService,
        coordinate: GeoCoordinate(latitude: 30.2672, longitude: -97.7431),
      ),
      TransitStop(
        id: 'S-03',
        name: 'Capitol Complex',
        routeId: 'R-101',
        status: StopStatus.inService,
        coordinate: GeoCoordinate(latitude: 30.2728, longitude: -97.7410),
      ),
      TransitStop(
        id: 'S-04',
        name: 'Seaholm',
        routeId: 'R-102',
        status: StopStatus.inService,
        coordinate: GeoCoordinate(latitude: 30.2678, longitude: -97.7530),
      ),
      TransitStop(
        id: 'S-05',
        name: 'Sixth & Congress',
        routeId: 'R-102',
        status: StopStatus.inService,
        coordinate: GeoCoordinate(latitude: 30.2674, longitude: -97.7431),
      ),
      TransitStop(
        id: 'S-06',
        name: 'Convention Center',
        routeId: 'R-102',
        status: StopStatus.inService,
        coordinate: GeoCoordinate(latitude: 30.2668, longitude: -97.7338),
      ),
      TransitStop(
        id: 'S-07',
        name: 'Auditorium Shores',
        routeId: 'R-103',
        status: StopStatus.inService,
        coordinate: GeoCoordinate(latitude: 30.2615, longitude: -97.7512),
      ),
      TransitStop(
        id: 'S-08',
        name: 'Rainey District',
        routeId: 'R-103',
        status: StopStatus.inService,
        coordinate: GeoCoordinate(latitude: 30.2638, longitude: -97.7352),
      ),
    ];

    final vehicles = [
      Vehicle(
        id: 'V-101',
        vehicleNumber: 'TR-101',
        driverName: 'A. Rivera',
        status: VehicleStatus.active,
        speedKph: 28,
        routeId: 'R-101',
        coordinate: GeoCoordinate(latitude: 30.2656, longitude: -97.7458),
        lastUpdated: updated,
      ),
      Vehicle(
        id: 'V-102',
        vehicleNumber: 'TR-102',
        driverName: 'John Smith',
        status: VehicleStatus.active,
        speedKph: 42,
        routeId: 'R-102',
        coordinate: GeoCoordinate(latitude: 30.2675, longitude: -97.7482),
        lastUpdated: updated,
      ),
      Vehicle(
        id: 'V-103',
        vehicleNumber: 'TR-103',
        driverName: 'M. Chen',
        status: VehicleStatus.active,
        speedKph: 19,
        routeId: 'R-103',
        coordinate: GeoCoordinate(latitude: 30.2620, longitude: -97.7478),
        lastUpdated: updated,
      ),
      Vehicle(
        id: 'V-104',
        vehicleNumber: 'TR-104',
        driverName: 'L. Patel',
        status: VehicleStatus.active,
        speedKph: 33,
        routeId: 'R-101',
        coordinate: GeoCoordinate(latitude: 30.2701, longitude: -97.7418),
        lastUpdated: updated,
      ),
      Vehicle(
        id: 'V-105',
        vehicleNumber: 'TR-105',
        driverName: 'S. Brooks',
        status: VehicleStatus.active,
        speedKph: 21,
        routeId: 'R-102',
        coordinate: GeoCoordinate(latitude: 30.2670, longitude: -97.7379),
        lastUpdated: updated,
      ),
      Vehicle(
        id: 'V-106',
        vehicleNumber: 'TR-106',
        driverName: 'K. Nguyen',
        status: VehicleStatus.active,
        speedKph: 37,
        routeId: 'R-103',
        coordinate: GeoCoordinate(latitude: 30.2631, longitude: -97.7394),
        lastUpdated: updated,
      ),
      Vehicle(
        id: 'V-107',
        vehicleNumber: 'TR-107',
        driverName: 'D. Alvarez',
        status: VehicleStatus.active,
        speedKph: 16,
        routeId: 'R-101',
        coordinate: GeoCoordinate(latitude: 30.2688, longitude: -97.7424),
        lastUpdated: updated,
      ),
      Vehicle(
        id: 'V-108',
        vehicleNumber: 'TR-108',
        driverName: 'P. Okonkwo',
        status: VehicleStatus.active,
        speedKph: 29,
        routeId: 'R-102',
        coordinate: GeoCoordinate(latitude: 30.2676, longitude: -97.7506),
        lastUpdated: updated,
      ),
      Vehicle(
        id: 'V-109',
        vehicleNumber: 'TR-109',
        driverName: 'H. Berg',
        status: VehicleStatus.active,
        speedKph: 24,
        routeId: 'R-103',
        coordinate: GeoCoordinate(latitude: 30.2628, longitude: -97.7436),
        lastUpdated: updated,
      ),
      Vehicle(
        id: 'V-110',
        vehicleNumber: 'TR-110',
        driverName: 'C. Rossi',
        status: VehicleStatus.active,
        speedKph: 31,
        routeId: 'R-101',
        coordinate: GeoCoordinate(latitude: 30.2664, longitude: -97.7448),
        lastUpdated: updated,
      ),
      Vehicle(
        id: 'V-111',
        vehicleNumber: 'TR-111',
        driverName: 'N. Singh',
        status: VehicleStatus.active,
        speedKph: 18,
        routeId: 'R-102',
        coordinate: GeoCoordinate(latitude: 30.2673, longitude: -97.7402),
        lastUpdated: updated,
      ),
      Vehicle(
        id: 'V-112',
        vehicleNumber: 'TR-112',
        driverName: 'E. Walsh',
        status: VehicleStatus.active,
        speedKph: 26,
        routeId: 'R-103',
        coordinate: GeoCoordinate(latitude: 30.2618, longitude: -97.7494),
        lastUpdated: updated,
      ),
    ];

    final incidents = [
      Incident(
        id: 'I-01',
        type: IncidentType.traffic,
        severity: IncidentSeverity.medium,
        description: 'Congestion near Sixth & Congress during peak service.',
        coordinate: GeoCoordinate(latitude: 30.2676, longitude: -97.7434),
        createdAt: updated,
        status: IncidentStatus.open,
      ),
      Incident(
        id: 'I-02',
        type: IncidentType.vehicleBreakdown,
        severity: IncidentSeverity.high,
        description: 'Disabled coach blocking the Riverside curb lane.',
        coordinate: GeoCoordinate(latitude: 30.2626, longitude: -97.7420),
        createdAt: updated,
        status: IncidentStatus.open,
      ),
    ];

    return GisCatalog(
      vehicles: vehicles,
      stops: stops,
      routes: routes,
      incidents: incidents,
    );
  }
}
