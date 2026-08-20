import 'package:flutter/material.dart';
import 'package:transitops_gis/domain/entities/selected_gis_feature.dart';
import 'package:transitops_gis/presentation/shared/widgets/app_card.dart';
import 'package:transitops_gis/presentation/shared/widgets/status_badge.dart';

class FeatureInfoCard extends StatelessWidget {
  const FeatureInfoCard({
    super.key,
    required this.feature,
    required this.onClose,
  });

  final SelectedGisFeature feature;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rows = feature.fields.entries.where(
      (entry) => !_hiddenKeys.contains(entry.key),
    );
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  feature.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              StatusBadge(label: feature.layerType.name, tone: StatusTone.info),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      row.key,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.65,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Text(row.value)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  static const _hiddenKeys = {'layerType', 'title', 'id'};
}
