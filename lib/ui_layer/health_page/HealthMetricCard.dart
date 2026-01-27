import 'package:flutter/material.dart';
import 'package:ice_shield/ui_layer/health_page/models/HealthMetric.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// Enhanced card widget that displays a health metric with animations and progress
class HealthMetricCard extends StatelessWidget {
  final HealthMetric metric;
  final bool compact;

  const HealthMetricCard({
    super.key,
    required this.metric,
    this.compact = false,
  });

  void _navigateToDetailPage(BuildContext context) {
    if (metric.detailPage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => metric.detailPage!),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Detail page for ${metric.name} coming soon!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2.0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: () => _navigateToDetailPage(context),
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: EdgeInsets.all(compact ? 16.0 : 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                metric.color.withOpacity(0.1),
                metric.color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: metric.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      metric.icon,
                      color: metric.color,
                      size: compact ? 24 : 28,
                    ),
                  ),
                  if (metric.trend != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (metric.trendPositive ?? true)
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            (metric.trendPositive ?? true)
                                ? Icons.trending_up
                                : Icons.trending_down,
                            size: 14,
                            color: (metric.trendPositive ?? true)
                                ? Colors.green
                                : Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            metric.trend!,
                            style: textTheme.bodySmall?.copyWith(
                              color: (metric.trendPositive ?? true)
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                metric.name,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      metric.value,
                      style: textTheme.headlineMedium?.copyWith(
                        color: metric.color,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      minFontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AutoSizeText(
                    metric.unit,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                    maxLines: 1,
                    minFontSize: 8,
                  ),
                ],
              ),
              if (metric.subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  metric.subtitle!,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (metric.progress != null) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: metric.progress!.clamp(0.0, 1.0),
                    minHeight: 6,
                    backgroundColor: metric.color.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(metric.color),
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
