import 'package:flutter/material.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  double sleepHours = 7.5;
  TimeOfDay bedTime = const TimeOfDay(hour: 23, minute: 0);
  TimeOfDay wakeTime = const TimeOfDay(hour: 6, minute: 30);
  final double recommendedSleep = 8.0;

  double get sleepQuality =>
      (sleepHours / recommendedSleep * 100).clamp(0, 100);
  double get sleepDeficit =>
      (recommendedSleep - sleepHours).clamp(0, recommendedSleep);
  int get sleepCycles => (sleepHours / 1.5).floor(); // 1 sleep cycle ≈ 90 min

  String get sleepRating {
    if (sleepHours >= 8) return 'Excellent';
    if (sleepHours >= 7) return 'Good';
    if (sleepHours >= 6) return 'Fair';
    return 'Poor';
  }

  Color get ratingColor {
    if (sleepHours >= 8) return Colors.green;
    if (sleepHours >= 7) return Colors.lightGreen;
    if (sleepHours >= 6) return Colors.orange;
    return Colors.red;
  }

  Future<void> _selectBedTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: bedTime,
    );
    if (picked != null) {
      setState(() {
        bedTime = picked;
        _calculateSleepHours();
      });
    }
  }

  Future<void> _selectWakeTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: wakeTime,
    );
    if (picked != null) {
      setState(() {
        wakeTime = picked;
        _calculateSleepHours();
      });
    }
  }

  void _calculateSleepHours() {
    double bedMinutes = (bedTime.hour * 60 + bedTime.minute).toDouble();
    double wakeMinutes = (wakeTime.hour * 60 + wakeTime.minute).toDouble();

    // Handle overnight sleep
    if (wakeMinutes < bedMinutes) {
      wakeMinutes += 24 * 60;
    }

    double totalMinutes = wakeMinutes - bedMinutes;
    sleepHours = totalMinutes / 60;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Sleep Tracker',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Main Sleep Display Card
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.bedtime, color: colorScheme.secondary, size: 64),
                    const SizedBox(height: 16),
                    Text(
                      'Last Night\'s Sleep',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          sleepHours.toStringAsFixed(1),
                          style: textTheme.displayLarge?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'hours',
                          style: textTheme.titleLarge?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: ratingColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ratingColor, width: 2),
                      ),
                      child: Text(
                        sleepRating,
                        style: textTheme.titleMedium?.copyWith(
                          color: ratingColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sleep Quality Progress
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: sleepQuality / 100,
                        minHeight: 12,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(ratingColor),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${sleepQuality.toStringAsFixed(0)}% of recommended sleep',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sleep Schedule
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sleep Schedule',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTimeSelector(
                            context,
                            'Bedtime',
                            bedTime,
                            Icons.nightlight_round,
                            _selectBedTime,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTimeSelector(
                            context,
                            'Wake Up',
                            wakeTime,
                            Icons.wb_sunny,
                            _selectWakeTime,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Statistics
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Sleep Cycles',
                    sleepCycles.toString(),
                    'cycles',
                    Icons.loop,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Sleep Deficit',
                    sleepDeficit.toStringAsFixed(1),
                    'hours',
                    Icons.trending_down,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Deep Sleep',
                    (sleepHours * 0.25).toStringAsFixed(1),
                    'hours',
                    Icons.dark_mode,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'REM Sleep',
                    (sleepHours * 0.20).toStringAsFixed(1),
                    'hours',
                    Icons.psychology,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Sleep Tips
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: colorScheme.secondary),
                        const SizedBox(width: 8),
                        Text(
                          'Sleep Tips',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTip('Maintain a consistent sleep schedule'),
                    _buildTip('Avoid caffeine 6 hours before bed'),
                    _buildTip('Keep your bedroom cool and dark'),
                    _buildTip('Limit screen time before sleep'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector(
    BuildContext context,
    String label,
    TimeOfDay time,
    IconData icon,
    VoidCallback onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: colorScheme.secondary),
            const SizedBox(height: 8),
            Text(label, style: textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(
              time.format(context),
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    String unit,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: colorScheme.secondary, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              unit,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String tip) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 20, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(child: Text(tip, style: textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
