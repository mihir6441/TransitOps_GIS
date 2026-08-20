import 'package:equatable/equatable.dart';
import 'package:transitops_gis/domain/entities/operations_snapshot.dart';

enum DashboardStatus { loading, loaded, empty, error }

class DashboardState extends Equatable {
  const DashboardState({
    required this.status,
    this.snapshot,
    this.message,
  });

  const DashboardState.loading() : this(status: DashboardStatus.loading);

  const DashboardState.loaded(OperationsSnapshot snapshot)
    : this(status: DashboardStatus.loaded, snapshot: snapshot);

  const DashboardState.empty() : this(status: DashboardStatus.empty);

  const DashboardState.error(String message)
    : this(status: DashboardStatus.error, message: message);

  final DashboardStatus status;
  final OperationsSnapshot? snapshot;
  final String? message;

  @override
  List<Object?> get props => [status, snapshot, message];
}
