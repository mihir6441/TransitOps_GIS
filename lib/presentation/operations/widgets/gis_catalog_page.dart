import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitops_gis/core/config/injection.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/domain/entities/gis_catalog.dart';
import 'package:transitops_gis/presentation/operations/cubit/gis_catalog_cubit.dart';
import 'package:transitops_gis/presentation/shared/widgets/empty_state.dart';
import 'package:transitops_gis/presentation/shared/widgets/error_state.dart';
import 'package:transitops_gis/presentation/shared/widgets/loading_state.dart';

class GisCatalogPage extends StatelessWidget {
  const GisCatalogPage({
    super.key,
    required this.title,
    required this.icon,
    required this.itemBuilder,
  });

  final String title;
  final IconData icon;
  final Widget Function(BuildContext context, GisCatalog catalog) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GisCatalogCubit>(),
      child: _GisCatalogView(
        title: title,
        icon: icon,
        itemBuilder: itemBuilder,
      ),
    );
  }
}

class _GisCatalogView extends StatelessWidget {
  const _GisCatalogView({
    required this.title,
    required this.icon,
    required this.itemBuilder,
  });

  final String title;
  final IconData icon;
  final Widget Function(BuildContext context, GisCatalog catalog) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GisCatalogCubit, GisCatalogState>(
      builder: (context, state) {
        return switch (state.status) {
          GisCatalogStatus.loading => LoadingState(
            message: 'Loading $title',
          ),
          GisCatalogStatus.empty => EmptyState(
            icon: icon,
            title: title,
            message: AppStrings.dashboardEmpty,
          ),
          GisCatalogStatus.error => ErrorState(
            message: state.message ?? AppStrings.unexpectedError,
            onRetry: () => context.read<GisCatalogCubit>().load(),
          ),
          GisCatalogStatus.loaded => itemBuilder(context, state.catalog!),
        };
      },
    );
  }
}
