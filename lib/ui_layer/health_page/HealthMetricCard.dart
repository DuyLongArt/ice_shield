import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ice_shield/ui_layer/health_page/models/HealthMetric.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// Enhanced card widget that displays a health metrics with animations and progress
class HealthMetricCard extends StatelessWidget {
  final HealthMetric metrics;
  late bool compact;

   HealthMetricCard({
    super.key,
    required this.metrics,
  });


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
    compact=MediaQuery.of(context).size.width < 600;

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
            //     metrics.color.withOpacity(0.05),
            //     metrics.color.withOpacity(0.02),
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
                      color: metrics.color.withOpacity(0.1), // Flatter look
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      metrics.icon,
                      color: metrics.color,
                      size: compact ? 20 : 64,
                    ),
                  ),
                  if (metrics.trend != null)
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          color: (metrics.trendPositive ?? true)
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: (metrics.trendPositive ?? true)
                                ? Colors.green.withOpacity(0.5)
                                : Colors.red.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              (metrics.trendPositive ?? true)
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              size: 12,
                              color: (metrics.trendPositive ?? true)
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 2),
                            
                            Text(
                metrics.name,
                style: textTheme.titleSmall?.copyWith(
                  color:metrics.color,
                  fontWeight: FontWeight.w600,
                  fontSize: compact ? 10 : 32,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              // const Spacer(),
              const SizedBox(height:12),
              
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      metrics.value,
                      style: textTheme.headlineSmall?.copyWith(
                        color: metrics.color,
                        fontWeight: FontWeight.bold,
                        fontSize: compact ? 10 : 24,
                      ),
                      maxLines: 1,
                      minFontSize: 12,
                    ),
                  ),
                  // const SizedBox(width: 4),
                  AutoSizeText(
                    metrics.unit,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                      fontSize: compact ? 10 : 24,
                    ),
                    maxLines: 1,
                    minFontSize: 8,
                  ),
                ],
              ),
              if (metrics.subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  metrics.subtitle!,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSecondary,
                    fontSize: compact ? 10 : 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (metrics.progress != null) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: metrics.progress!.clamp(0.0, 1.0),
                    minHeight: 4,
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
