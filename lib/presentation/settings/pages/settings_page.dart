import 'package:flutter/material.dart';
import 'package:transitops_gis/core/config/app_config.dart';
import 'package:transitops_gis/core/config/injection.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/core/gis/arcgis_runtime_service.dart';
import 'package:transitops_gis/presentation/shared/widgets/app_card.dart';
import 'package:transitops_gis/presentation/shared/widgets/status_badge.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final config = sl<AppConfig>();
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          AppStrings.settings,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Environment and runtime configuration. Secrets are never stored in source.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            children: [
              _SettingRow(
                label: 'Environment',
                value: config.environment.name,
              ),
              const Divider(height: 24),
              _SettingRow(label: 'API base URL', value: config.apiBaseUrl),
              const Divider(height: 24),
              _SettingRow(
                label: 'ArcGIS portal',
                value: config.arcgisPortalUrl,
              ),
              const Divider(height: 24),
              Row(
                children: [
                  const Expanded(child: Text('ArcGIS API key')),
                  StatusBadge(
                    label: config.hasArcgisApiKey ? 'Configured' : 'Not set',
                    tone: config.hasArcgisApiKey
                        ? StatusTone.success
                        : StatusTone.warning,
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  const Expanded(child: Text('ArcGIS runtime')),
                  StatusBadge(
                    label: sl<ArcGISRuntimeService>().isReady
                        ? 'Initialized'
                        : 'Idle',
                    tone: sl<ArcGISRuntimeService>().isReady
                        ? StatusTone.success
                        : StatusTone.neutral,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
