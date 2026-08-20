import 'package:transitops_gis/core/error/result.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/domain/repositories/gis_repository.dart';
import 'package:transitops_gis/domain/usecases/use_case.dart';

class GetGisCatalog extends UseCase<GisCatalog, NoParams> {
  GetGisCatalog(this._repository);

  final GisRepository _repository;

  @override
  Future<Result<GisCatalog>> call(NoParams params) {
    return _repository.getCatalog();
  }
}
