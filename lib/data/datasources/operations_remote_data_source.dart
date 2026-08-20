import 'package:transitops_gis/domain/entities/operations_snapshot.dart';

abstract class OperationsRemoteDataSource {
  Future<OperationsSnapshot> fetchSnapshot();
}
