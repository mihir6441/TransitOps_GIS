import 'package:flutter/material.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/shared/widgets/module_placeholder_page.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholderPage(
      title: AppStrings.vehicles,
      icon: Icons.directions_bus_outlined,
    );
  }
}
