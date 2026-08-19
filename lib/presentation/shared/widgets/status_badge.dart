import 'package:flutter/material.dart';
import 'package:transitops_gis/core/theme/app_colors.dart';

enum StatusTone { neutral, success, warning, danger, info }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    this.tone = StatusTone.neutral,
  });

  final String label;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = _colorsFor(tone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: colors.foreground,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  ({Color background, Color foreground}) _colorsFor(StatusTone tone) {
    return switch (tone) {
      StatusTone.success => (
        background: AppColors.success.withValues(alpha: 0.12),
        foreground: AppColors.success,
      ),
      StatusTone.warning => (
        background: AppColors.warning.withValues(alpha: 0.14),
        foreground: AppColors.warning,
      ),
      StatusTone.danger => (
        background: AppColors.danger.withValues(alpha: 0.12),
        foreground: AppColors.danger,
      ),
      StatusTone.info => (
        background: AppColors.teal.withValues(alpha: 0.12),
        foreground: AppColors.teal,
      ),
      StatusTone.neutral => (
        background: AppColors.slate.withValues(alpha: 0.12),
        foreground: AppColors.slate,
      ),
    };
  }
}
