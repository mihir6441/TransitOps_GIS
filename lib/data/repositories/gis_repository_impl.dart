import 'package:transitops_gis/core/error/failures.dart';
import 'package:transitops_gis/core/error/result.dart';
import 'package:transitops_gis/data/datasources/gis_remote_data_source.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/domain/repositories/gis_repository.dart';

class GisRepositoryImpl implements GisRepository {
  const GisRepositoryImpl(this._remote);

  final GisRemoteDataSource _remote;

  @override
  Future<Result<GisCatalog>> getCatalog() async {
    try {
      return Success(await _remote.fetchCatalog());
    } catch (error) {
      return FailureResult(mapExceptionToFailure(error));
    }
  }
}
