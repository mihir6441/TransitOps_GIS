import 'package:transitops_gis/core/error/result.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/domain/entities/operations_snapshot.dart';
import 'package:transitops_gis/domain/repositories/gis_repository.dart';
import 'package:transitops_gis/domain/repositories/operations_repository.dart';

class OperationsRepositoryImpl implements OperationsRepository {
  const OperationsRepositoryImpl(this._gisRepository);

  final GisRepository _gisRepository;

  @override
  Future<Result<OperationsSnapshot>> getSnapshot() async {
    final catalogResult = await _gisRepository.getCatalog();
    return catalogResult.fold(
      onSuccess: (catalog) {
        return Success(_fromCatalog(catalog));
      },
      onFailure: FailureResult.new,
    );
  }

  OperationsSnapshot _fromCatalog(GisCatalog catalog) {
    return OperationsSnapshot(
      activeVehicles: catalog.activeVehicleCount,
      totalStops: catalog.stops.length,
      activeRoutes: catalog.activeRouteCount,
      openIncidents: catalog.openIncidentCount,
      sourceLabel: 'GIS operations snapshot',
    );
  }
}
