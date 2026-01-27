import 'package:flutter/material.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({super.key});

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  int _currentWater = 1200; // in ml
  final int _goalWater = 2500; // in ml

  void _addWater(int amount) {
    setState(() {
      _currentWater += amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    double progress = (_currentWater / _goalWater).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 12,
                      backgroundColor: Colors.blue.withOpacity(0.1),
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(
                        Icons.water_drop,
                        size: 48,
                        color: Colors.blue,
                      ),
                      Text(
                        '$_currentWater',
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text('of $_goalWater ml', style: textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildWaterAddButton(100, '100ml'),
                  _buildWaterAddButton(250, '250ml'),
                  _buildWaterAddButton(500, '500ml'),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentWater = 0;
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Today'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWaterAddButton(int amount, String label) {
    return Column(
      children: [
        IconButton.filledTonal(
          onPressed: () => _addWater(amount),
          icon: const Icon(Icons.add),
          padding: const EdgeInsets.all(16),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
