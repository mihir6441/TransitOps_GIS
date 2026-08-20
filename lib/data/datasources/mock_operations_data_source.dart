import 'package:transitops_gis/data/datasources/operations_remote_data_source.dart';
import 'package:transitops_gis/domain/entities/operations_snapshot.dart';

/// Demo operations feed. Replace with a GIS/feature-service source in later phases.
class MockOperationsDataSource implements OperationsRemoteDataSource {
  const MockOperationsDataSource();

  @override
  Future<OperationsSnapshot> fetchSnapshot() async {
    return const OperationsSnapshot(
      activeVehicles: 12,
      totalStops: 8,
      activeRoutes: 3,
      openIncidents: 2,
      sourceLabel: 'Demo operations snapshot',
    );
  }
}
