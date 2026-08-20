import 'package:transitops_gis/domain/entities/gis_catalog.dart';

abstract class GisRemoteDataSource {
  Future<GisCatalog> fetchCatalog();
}
