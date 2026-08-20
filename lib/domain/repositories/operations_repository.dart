import 'package:transitops_gis/core/error/result.dart';
import 'package:transitops_gis/domain/entities/operations_snapshot.dart';

abstract class OperationsRepository {
  Future<Result<OperationsSnapshot>> getSnapshot();
}
