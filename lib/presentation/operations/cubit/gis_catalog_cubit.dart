import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/domain/usecases/get_gis_catalog.dart';
import 'package:transitops_gis/domain/usecases/use_case.dart';

enum GisCatalogStatus { loading, loaded, empty, error }

class GisCatalogState extends Equatable {
  const GisCatalogState({
    required this.status,
    this.catalog,
    this.message,
  });

  final GisCatalogStatus status;
  final GisCatalog? catalog;
  final String? message;

  @override
  List<Object?> get props => [status, catalog, message];
}

class GisCatalogCubit extends Cubit<GisCatalogState> {
  GisCatalogCubit(this._getGisCatalog)
    : super(const GisCatalogState(status: GisCatalogStatus.loading)) {
    load();
  }

  final GetGisCatalog _getGisCatalog;

  Future<void> load() async {
    emit(const GisCatalogState(status: GisCatalogStatus.loading));
    final result = await _getGisCatalog(const NoParams());
    result.fold(
      onSuccess: (catalog) {
        final isEmpty =
            catalog.vehicles.isEmpty &&
            catalog.routes.isEmpty &&
            catalog.incidents.isEmpty;
        emit(
          GisCatalogState(
            status: isEmpty ? GisCatalogStatus.empty : GisCatalogStatus.loaded,
            catalog: catalog,
          ),
        );
      },
      onFailure: (failure) {
        emit(
          GisCatalogState(
            status: GisCatalogStatus.error,
            message: failure.message,
          ),
        );
      },
    );
  }
}
