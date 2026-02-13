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
      appBar: AppBar(
        title: Text(
          'Heart Rate Monitor',
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
            // Current Heart Rate Card
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.favorite, color: zoneColor, size: 64),
                    const SizedBox(height: 16),
                    Text(
                      'Current Heart Rate',
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
                          currentHeartRate.toString(),
                          style: textTheme.displayLarge?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'bpm',
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
                        color: zoneColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: zoneColor, width: 2),
                      ),
                      child: Text(
                        heartRateZone,
                        style: textTheme.titleMedium?.copyWith(
                          color: zoneColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                    'Average',
                    averageHeartRate.toString(),
                    'bpm',
                    Icons.analytics,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Maximum',
                    maxHeartRate.toString(),
                    'bpm',
                    Icons.arrow_upward,
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
                    'Minimum',
                    minHeartRate.toString(),
                    'bpm',
                    Icons.arrow_downward,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Readings',
                    recentReadings.length.toString(),
                    'total',
                    Icons.history,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Add Reading Section
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
                      'Add Heart Rate Reading',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _bpmController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'BPM (40-220)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.favorite),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: _addReading,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Heart Rate Zones Info
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
                      'Heart Rate Zones',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildZoneInfo(context, 'Resting', '< 60 bpm', Colors.blue),
                    _buildZoneInfo(
                      context,
                      'Normal',
                      '60-100 bpm',
                      Colors.green,
                    ),
                    _buildZoneInfo(
                      context,
                      'Elevated',
                      '100-140 bpm',
                      Colors.orange,
                    ),
                    _buildZoneInfo(context, 'High', '> 140 bpm', Colors.red),
                  ],
                ),
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

  Widget _buildZoneInfo(
    BuildContext context,
    String zone,
    String range,
    Color color,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              zone,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            range,
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
