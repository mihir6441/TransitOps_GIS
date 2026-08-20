import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/domain/usecases/get_operations_snapshot.dart';
import 'package:transitops_gis/domain/usecases/use_case.dart';
import 'package:transitops_gis/presentation/dashboard/cubit/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._getOperationsSnapshot)
    : super(const DashboardState.loading()) {
    load();
  }

  final GetOperationsSnapshot _getOperationsSnapshot;

  Future<void> load() async {
    emit(const DashboardState.loading());
    final result = await _getOperationsSnapshot(const NoParams());
    result.fold(
      onSuccess: (snapshot) {
        if (snapshot.isEmpty) {
          emit(const DashboardState.empty());
          return;
        }
        emit(DashboardState.loaded(snapshot));
      },
      onFailure: (failure) {
        emit(
          DashboardState.error(
            failure.message.isEmpty
                ? AppStrings.unexpectedError
                : failure.message,
          ),
        );
      },
    );
  }
}
