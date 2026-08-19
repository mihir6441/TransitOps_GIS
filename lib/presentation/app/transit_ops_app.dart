import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitops_gis/core/config/injection.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/core/theme/app_theme.dart';
import 'package:transitops_gis/presentation/app/app_router.dart';
import 'package:transitops_gis/presentation/app/app_routes.dart';
import 'package:transitops_gis/presentation/navigation/navigation_cubit.dart';

class TransitOpsApp extends StatelessWidget {
  const TransitOpsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NavigationCubit>(),
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRoutes.shell,
      ),
    );
  }
}
