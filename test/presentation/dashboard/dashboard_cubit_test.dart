import 'package:flutter_test/flutter_test.dart';
import 'package:transitops_gis/core/error/failures.dart';
import 'package:transitops_gis/core/error/result.dart';
import 'package:transitops_gis/domain/entities/operations_snapshot.dart';
import 'package:transitops_gis/domain/usecases/get_operations_snapshot.dart';
import 'package:transitops_gis/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:transitops_gis/presentation/dashboard/cubit/dashboard_state.dart';

import '../../helpers/fake_operations_repository.dart';

Future<void> _waitUntilSettled(DashboardCubit cubit) async {
  if (cubit.state.status != DashboardStatus.loading) {
    return;
  }
  await cubit.stream.firstWhere(
    (state) => state.status != DashboardStatus.loading,
  );
}

void main() {
  const snapshot = OperationsSnapshot(
    activeVehicles: 12,
    totalStops: 8,
    activeRoutes: 3,
    openIncidents: 2,
    sourceLabel: 'test',
  );

  test('emits loaded when snapshot has metrics', () async {
    final cubit = DashboardCubit(
      GetOperationsSnapshot(FakeOperationsRepository(const Success(snapshot))),
    );
    await _waitUntilSettled(cubit);
    expect(cubit.state.status, DashboardStatus.loaded);
    expect(cubit.state.snapshot, snapshot);
    await cubit.close();
  });

  test('emits empty when all counts are zero', () async {
    const empty = OperationsSnapshot(
      activeVehicles: 0,
      totalStops: 0,
      activeRoutes: 0,
      openIncidents: 0,
      sourceLabel: 'test',
    );
    final cubit = DashboardCubit(
      GetOperationsSnapshot(FakeOperationsRepository(const Success(empty))),
    );
    await _waitUntilSettled(cubit);
    expect(cubit.state.status, DashboardStatus.empty);
    await cubit.close();
  });

  test('emits error when the repository fails', () async {
    final cubit = DashboardCubit(
      GetOperationsSnapshot(
        FakeOperationsRepository(const FailureResult(NetworkFailure('offline'))),
      ),
    );
    await _waitUntilSettled(cubit);
    expect(cubit.state.status, DashboardStatus.error);
    expect(cubit.state.message, 'offline');
    await cubit.close();
  });
}
