import 'package:flutter/material.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/operations/widgets/gis_catalog_page.dart';
import 'package:transitops_gis/presentation/shared/widgets/app_card.dart';
import 'package:transitops_gis/presentation/shared/widgets/status_badge.dart';

class IncidentsPage extends StatelessWidget {
  const IncidentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GisCatalogPage(
      title: AppStrings.incidents,
      icon: Icons.report_outlined,
      itemBuilder: (context, catalog) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: catalog.incidents.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final incident = catalog.incidents[index];
            return AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          incident.type.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      StatusBadge(
                        label: incident.severity.name,
                        tone: incident.severity.name == 'high' ||
                                incident.severity.name == 'critical'
                            ? StatusTone.danger
                            : StatusTone.warning,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(incident.description),
                  const SizedBox(height: 8),
                  StatusBadge(label: incident.status.name),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
