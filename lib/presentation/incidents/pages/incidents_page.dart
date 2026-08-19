import 'package:flutter/material.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/shared/widgets/module_placeholder_page.dart';

class IncidentsPage extends StatelessWidget {
  const IncidentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholderPage(
      title: AppStrings.incidents,
      icon: Icons.report_outlined,
    );
  }
}
