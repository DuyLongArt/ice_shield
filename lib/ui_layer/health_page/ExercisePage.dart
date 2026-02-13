import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final List<Map<String, dynamic>> _activities = [
    {
      'name': 'Running',
      'duration': '30 min',
      'calories': 300,
      'icon': Icons.directions_run,
    },
    {
      'name': 'Cycling',
      'duration': '45 min',
      'calories': 450,
      'icon': Icons.directions_bike,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Tracker'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn('Duration', '75', 'min', colorScheme),
                    _buildStatColumn('Burned', '750', 'kcal', colorScheme),
                    _buildStatColumn('Workouts', '2', '', colorScheme),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Recent Activities',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                final activity = _activities[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colorScheme.secondaryContainer,
                      child: Icon(
                        activity['icon'],
                        color: colorScheme.secondary,
                      ),
                    ),
                    title: Text(activity['name']),
                    subtitle: Text(activity['duration']),
                    trailing: Text(
                      '${activity['calories']} kcal',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatColumn(
    String label,
    String value,
    String unit,
    ColorScheme colorScheme,
  ) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            if (unit.isNotEmpty)
              Text(' $unit', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
