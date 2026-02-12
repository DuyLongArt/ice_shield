import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ice_shield/ui_layer/health_page/models/HealthMetric.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// Enhanced card widget that displays a health metrics with animations and progress
class HealthMetricCard extends StatelessWidget {
  final HealthMetric metrics;
  late bool compact;

  HealthMetricCard({super.key, required this.metrics});

  void _navigateToDetailPage(BuildContext context) {
    if (metrics.detailPage != null) {
      context.go(metrics.detailPage!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Detail page for ${metrics.name} coming soon!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    compact = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => _navigateToDetailPage(context),
        borderRadius: BorderRadius.circular(28.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: metrics.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      metrics.icon,
                      color: metrics.color,
                      size: compact ? 22 : 28,
                    ),
                  ),
                  if (metrics.trend != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (metrics.trendPositive ?? true)
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            (metrics.trendPositive ?? true)
                                ? Icons.trending_up
                                : Icons.trending_down,
                            size: 14,
                            color: (metrics.trendPositive ?? true)
                                ? Colors.green
                                : Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            metrics.trend!,
                            style: TextStyle(
                              color: (metrics.trendPositive ?? true)
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.w900,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                metrics.name.toUpperCase(),
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      metrics.value,
                      style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w900,
                        fontSize: compact ? 24 : 28,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    metrics.unit,
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              if (metrics.progress != null) ...[
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: metrics.progress!.clamp(0.0, 1.0),
                    minHeight: 6,
                    backgroundColor: metrics.color.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(metrics.color),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
