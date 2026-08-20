import 'package:flutter_test/flutter_test.dart';
import 'package:transitops_gis/core/error/failures.dart';
import 'package:transitops_gis/core/error/result.dart';
import 'package:transitops_gis/data/datasources/gis_remote_data_source.dart';
import 'package:transitops_gis/data/datasources/mock_gis_data_source.dart';
import 'package:transitops_gis/data/repositories/gis_repository_impl.dart';
import 'package:transitops_gis/data/repositories/operations_repository_impl.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/domain/entities/operations_snapshot.dart';
import 'package:transitops_gis/domain/usecases/get_operations_snapshot.dart';
import 'package:transitops_gis/domain/usecases/use_case.dart';

void main() {
  test('mock GIS catalog matches dashboard KPI counts', () async {
    const source = MockGisDataSource();
    final catalog = await source.fetchCatalog();
    expect(catalog.activeVehicleCount, 12);
    expect(catalog.stops.length, 8);
    expect(catalog.activeRouteCount, 3);
    expect(catalog.openIncidentCount, 2);
  });

  test('operations snapshot is derived from the GIS catalog', () async {
    final gis = GisRepositoryImpl(const MockGisDataSource());
    final useCase = GetOperationsSnapshot(OperationsRepositoryImpl(gis));
    final result = await useCase(const NoParams());

    expect(result, isA<Success<OperationsSnapshot>>());
    result.fold(
      onSuccess: (snapshot) {
        expect(snapshot.activeVehicles, 12);
        expect(snapshot.totalStops, 8);
        expect(snapshot.activeRoutes, 3);
        expect(snapshot.openIncidents, 2);
      },
      onFailure: (_) => fail('expected success'),
    );
  });

  test('repository maps unexpected GIS errors to failures', () async {
    final repository = GisRepositoryImpl(_ThrowingGisSource());
    final result = await repository.getCatalog();
    expect(result, isA<FailureResult<GisCatalog>>());
    result.fold(
      onSuccess: (_) => fail('expected failure'),
      onFailure: (failure) => expect(failure, isA<UnexpectedFailure>()),
    );
  });
}

class _ThrowingGisSource implements GisRemoteDataSource {
  @override
  Future<GisCatalog> fetchCatalog() {
    throw StateError('unavailable');
  }
}
