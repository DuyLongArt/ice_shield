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

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colorScheme.outline, width: 1),
      ),
      child: InkWell(
        onTap: () => _navigateToDetailPage(context),
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            // Optional: Keep a very subtle gradient or remove it for purer flat style
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     metric.color.withOpacity(0.05),
            //     metric.color.withOpacity(0.02),
            //   ],
            // ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: metric.color.withOpacity(0.1), // Flatter look
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      metric.icon,
                      color: metric.color,
                      size: compact ? 20 : 24,
                    ),
                  ),
                  if (metric.trend != null)
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          color: (metric.trendPositive ?? true)
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: (metric.trendPositive ?? true)
                                ? Colors.green.withOpacity(0.5)
                                : Colors.red.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              (metric.trendPositive ?? true)
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              size: 12,
                              color: (metric.trendPositive ?? true)
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 2),
                            Flexible(
                              child: Text(
                                metric.trend!,
                                style: textTheme.bodySmall?.copyWith(
                                  color: (metric.trendPositive ?? true)
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                metric.name,
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      metric.value,
                      style: textTheme.headlineSmall?.copyWith(
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
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    minFontSize: 8,
                  ),
                ],
              ),
              if (metric.subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  metric.subtitle!,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.5),
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (metric.progress != null) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: metric.progress!.clamp(0.0, 1.0),
                    minHeight: 4,
                    backgroundColor: metric.color.withOpacity(0.1),
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
