import 'package:flutter/material.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/shared/widgets/module_placeholder_page.dart';

class LiveMapPage extends StatelessWidget {
  const LiveMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholderPage(
      title: AppStrings.liveMap,
      icon: Icons.map_outlined,
    );
  }
}
