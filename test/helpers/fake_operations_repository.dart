import 'package:transitops_gis/core/error/result.dart';
import 'package:transitops_gis/domain/entities/operations_snapshot.dart';
import 'package:transitops_gis/domain/repositories/operations_repository.dart';

class FakeOperationsRepository implements OperationsRepository {
  FakeOperationsRepository(this.result);

  Result<OperationsSnapshot> result;

  @override
  Future<Result<OperationsSnapshot>> getSnapshot() async => result;
}
