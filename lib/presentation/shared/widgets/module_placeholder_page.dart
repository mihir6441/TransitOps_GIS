import 'package:flutter/material.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/shared/widgets/empty_state.dart';

class ModulePlaceholderPage extends StatelessWidget {
  const ModulePlaceholderPage({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: icon,
      title: title,
      message: AppStrings.foundationNotice,
    );
  }
}
