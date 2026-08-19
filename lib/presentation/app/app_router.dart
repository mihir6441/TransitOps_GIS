import 'package:flutter/material.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/app/app_routes.dart';
import 'package:transitops_gis/presentation/shell/app_shell.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.shell:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const AppShell(),
        );
      default:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const _UnknownRoutePage(),
        );
    }
  }
}

class _UnknownRoutePage extends StatelessWidget {
  const _UnknownRoutePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: const Center(child: Text('Page not found')),
    );
  }
}
