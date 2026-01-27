import 'package:flutter/material.dart';

class StepsPage extends StatefulWidget {
  const StepsPage({super.key});

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  int currentSteps = 8500;
  final int dailyGoal = 10000;
  final TextEditingController _stepsController = TextEditingController();

  @override
  void dispose() {
    _stepsController.dispose();
    super.dispose();
  }

  double get progressPercentage =>
      (currentSteps / dailyGoal * 100).clamp(0, 100);
  int get remainingSteps => (dailyGoal - currentSteps).clamp(0, dailyGoal);
  double get distanceKm => currentSteps * 0.0008; // Average: 1 step ≈ 0.8m
  int get caloriesBurned =>
      (currentSteps * 0.04).round(); // Average: 1 step ≈ 0.04 cal

  void _addSteps() {
    final steps = int.tryParse(_stepsController.text);
    if (steps != null && steps > 0) {
      setState(() {
        currentSteps += steps;
        _stepsController.clear();
      });
    }
  }

  void _resetSteps() {
    setState(() {
      currentSteps = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Steps Tracker',
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
            // Main Steps Display Card
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Today\'s Steps',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentSteps.toString(),
                      style: textTheme.displayLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Goal: $dailyGoal steps',
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: currentSteps / dailyGoal,
                        minHeight: 12,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${progressPercentage.toStringAsFixed(1)}% Complete',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Statistics Grid
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Remaining',
                    remainingSteps.toString(),
                    'steps',
                    Icons.flag,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Distance',
                    distanceKm.toStringAsFixed(2),
                    'km',
                    Icons.straighten,
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
                    'Calories',
                    caloriesBurned.toString(),
                    'kcal',
                    Icons.local_fire_department,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Active Time',
                    '${(currentSteps / 100).round()}',
                    'min',
                    Icons.timer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Add Steps Section
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
                      'Add Steps Manually',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _stepsController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Number of steps',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.directions_walk),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: _addSteps,
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
            const SizedBox(height: 16),

            // Reset Button
            OutlinedButton.icon(
              onPressed: _resetSteps,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Today\'s Steps'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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
}
