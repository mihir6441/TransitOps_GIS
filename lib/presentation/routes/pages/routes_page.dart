import 'package:flutter/material.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/operations/widgets/gis_catalog_page.dart';
import 'package:transitops_gis/presentation/shared/widgets/app_card.dart';
import 'package:transitops_gis/presentation/shared/widgets/status_badge.dart';

class RoutesPage extends StatelessWidget {
  const RoutesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GisCatalogPage(
      title: AppStrings.routes,
      icon: Icons.alt_route_outlined,
      itemBuilder: (context, catalog) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: catalog.routes.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final route = catalog.routes[index];
            return AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${route.routeNumber}  ${route.name}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      StatusBadge(
                        label: route.status.name,
                        tone: StatusTone.info,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('${route.startLocation} → ${route.destination}'),
                  Text('${route.distanceKm} km'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
