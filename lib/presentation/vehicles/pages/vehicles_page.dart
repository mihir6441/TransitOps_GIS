import 'package:flutter/material.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/operations/widgets/gis_catalog_page.dart';
import 'package:transitops_gis/presentation/shared/widgets/app_card.dart';
import 'package:transitops_gis/presentation/shared/widgets/status_badge.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GisCatalogPage(
      title: AppStrings.vehicles,
      icon: Icons.directions_bus_outlined,
      itemBuilder: (context, catalog) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: catalog.vehicles.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final vehicle = catalog.vehicles[index];
            return AppCard(
              child: Row(
                children: [
                  const Icon(Icons.directions_bus_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.vehicleNumber,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text('${vehicle.driverName} · ${vehicle.routeId}'),
                      ],
                    ),
                  ),
                  StatusBadge(
                    label: vehicle.status.name,
                    tone: vehicle.status.name == 'active'
                        ? StatusTone.success
                        : StatusTone.neutral,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
