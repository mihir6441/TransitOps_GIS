import 'package:transitops_gis/core/error/result.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';

abstract class GisRepository {
  Future<Result<GisCatalog>> getCatalog();
}
