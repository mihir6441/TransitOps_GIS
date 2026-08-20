import 'package:transitops_gis/core/error/result.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/domain/repositories/gis_repository.dart';

class FakeGisRepository implements GisRepository {
  FakeGisRepository(this.result);

  Result<GisCatalog> result;

  @override
  Future<Result<GisCatalog>> getCatalog() async => result;
}
