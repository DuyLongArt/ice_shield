import 'dart:ui';
import 'package:flutter/material.dart';

class HeartRatePage extends StatefulWidget {
  const HeartRatePage({super.key});

  @override
  State<HeartRatePage> createState() => _HeartRatePageState();
}

class _HeartRatePageState extends State<HeartRatePage> {
  int currentHeartRate = 72;
  final List<int> recentReadings = [68, 70, 72, 75, 71, 69, 72];
  final TextEditingController _bpmController = TextEditingController();

  @override
  void dispose() {
    _bpmController.dispose();
    super.dispose();
  }

  int get averageHeartRate {
    if (recentReadings.isEmpty) return 0;
    return (recentReadings.reduce((a, b) => a + b) / recentReadings.length)
        .round();
  }

  int get maxHeartRate => recentReadings.isEmpty
      ? 0
      : recentReadings.reduce((a, b) => a > b ? a : b);
  int get minHeartRate => recentReadings.isEmpty
      ? 0
      : recentReadings.reduce((a, b) => a < b ? a : b);

  String get heartRateZone {
    if (currentHeartRate < 60) return 'Resting';
    if (currentHeartRate < 100) return 'Normal';
    if (currentHeartRate < 140) return 'Elevated';
    if (currentHeartRate < 170) return 'High';
    return 'Very High';
  }

  Color get zoneColor {
    if (currentHeartRate < 60) return Colors.blue;
    if (currentHeartRate < 100) return Colors.green;
    if (currentHeartRate < 140) return Colors.orange;
    return Colors.red;
  }

  void _addReading() {
    final bpm = int.tryParse(_bpmController.text);
    if (bpm != null && bpm > 0 && bpm < 250) {
      setState(() {
        currentHeartRate = bpm;
        recentReadings.add(bpm);
        if (recentReadings.length > 10) {
          recentReadings.removeAt(0);
        }
        _bpmController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: zoneColor.withValues(alpha: 0.15),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        'Heart Rate',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Main Heart Rate Display
                  Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: zoneColor.withValues(alpha: 0.2),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        border: Border.all(
                          color: zoneColor.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 1.0, end: 1.2),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.elasticOut,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Icon(
                                  Icons.favorite_rounded,
                                  color: zoneColor,
                                  size: 60,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                currentHeartRate.toString(),
                                style: textTheme.displayLarge?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 72,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'bpm',
                                style: textTheme.titleLarge?.copyWith(
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.5,
                                  ),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: zoneColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              heartRateZone.toUpperCase(),
                              style: textTheme.titleSmall?.copyWith(
                                color: zoneColor,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Statistics Grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = (constraints.maxWidth - 15) / 2;
                      return Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: [
                          _modernStatCard(
                            context,
                            'Average',
                            averageHeartRate.toString(),
                            'bpm',
                            Icons.analytics_rounded,
                            cardWidth,
                          ),
                          _modernStatCard(
                            context,
                            'Peak',
                            maxHeartRate.toString(),
                            'bpm',
                            Icons.trending_up_rounded,
                            cardWidth,
                          ),
                          _modernStatCard(
                            context,
                            'Resting',
                            minHeartRate.toString(),
                            'bpm',
                            Icons.trending_down_rounded,
                            cardWidth,
                          ),
                          _modernStatCard(
                            context,
                            'Samples',
                            recentReadings.length.toString(),
                            'total',
                            Icons.history_toggle_off_rounded,
                            cardWidth,
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Manual Entry Section
                  Text(
                    'Manual Entry',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer.withValues(
                            alpha: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withValues(
                              alpha: 0.2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _bpmController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Enter BPM',
                                  filled: true,
                                  fillColor: colorScheme.surface,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            ElevatedButton(
                              onPressed: _addReading,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: colorScheme.onPrimary,
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                              child: const Icon(Icons.add_rounded),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modernStatCard(
    BuildContext context,
    String label,
    String value,
    String unit,
    IconData icon,
    double width,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colorScheme.primary, size: 24),
          const SizedBox(height: 15),
          Text(
            value,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            '$label ($unit)',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
