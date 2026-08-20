import 'package:transitops_gis/core/error/result.dart';
import 'package:transitops_gis/domain/entities/operations_snapshot.dart';
import 'package:transitops_gis/domain/repositories/operations_repository.dart';
import 'package:transitops_gis/domain/usecases/use_case.dart';

class GetOperationsSnapshot extends UseCase<OperationsSnapshot, NoParams> {
  GetOperationsSnapshot(this._repository);

  final OperationsRepository _repository;

  @override
  Future<Result<OperationsSnapshot>> call(NoParams params) {
    return _repository.getSnapshot();
  }
}
