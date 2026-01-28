import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:ice_shield/ui_layer/health_page/HealthMetricCard.dart';
import 'package:ice_shield/ui_layer/health_page/CaloriesMetrics.dart';
import 'package:ice_shield/ui_layer/health_page/models/HealthMetric.dart';
import 'package:ice_shield/data_layer/Protocol/Health/HealthMetricsData.dart';
import 'package:ice_shield/ui_layer/health_page/widgets/HealthPageHeader.dart';
import 'package:ice_shield/ui_layer/home_page/MainButton.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  static Widget icon(BuildContext context, {double? size}) {
    final colorScheme = Theme.of(context).colorScheme;
    return MainButton(
      type: "health",
      destination: "/health",
      size: size,
      mainFunction: () {
        context.go('/health');
      },
      icon: Icons.favorite,
      subButtons: [
        SubButton(
          icon: Icons.restaurant,
          backgroundColor: Colors.orange,
          onPressed: () => context.go('/health/food'),
        ),
        SubButton(
          icon: Icons.fitness_center,
          backgroundColor: Colors.red,
          onPressed: () => context.go('/health/exercise'),
        ),
        SubButton(
          icon: Icons.bedtime,
          backgroundColor: Colors.indigo,
          onPressed: () => context.go('/health/sleep'),
        ),
        SubButton(
          icon: Icons.water_drop,
          backgroundColor: Colors.cyan,
          onPressed: () => context.go('/health/water'),
        ),
      ],
    );
  }

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  late AppDatabase database;
  late HealthMealDAO _mealDao;

  @override
  void initState() {
    super.initState();
    database = context.read<AppDatabase>();
    _mealDao = database.healthMealDAO;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: StreamBuilder<List<DayWithMeal>>(
        stream: _mealDao.watchDaysWithMeals(),
        builder: (context, mealSnapshot) {
          return StreamBuilder<HealthMetricsLocal?>(
            stream: database
                .select(database.healthMetricsTable)
                .watchSingleOrNull(),
            builder: (context, metricsSnapshot) {
              final meals = mealSnapshot.data ?? [];
              final metrics = metricsSnapshot.data;

              // Calculate real nutrition data
              double protein = 0;
              double carbs = 0;
              double fat = 0;
              int totalCals = 0;
              for (var m in meals) {
                totalCals += m.day.totalCalories;
                protein += m.meal.protein;
                carbs += m.meal.carbs;
                fat += m.meal.fat;
              }

              const dailyGoal = 2000;
              final progress = (totalCals / dailyGoal).clamp(0.0, 1.0);

              return RefreshIndicator(
                onRefresh: () async => setState(() {}),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: HealthPageHeader(
                        completedGoals: (progress >= 1.0) ? 1 : 0,
                        totalGoals: 5,
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nutrition',
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.go('/health/food/dashboard'),
                              child: Text(
                                'View Logs',
                                style: TextStyle(color: colorScheme.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: () => context.go('/health/food/dashboard'),
                          child: Column(
                            children: [
                              CaloriesMainDisplay(
                                netCalories: totalCals,
                                dailyGoal: dailyGoal,
                                calorieStatus: totalCals > dailyGoal
                                    ? 'Limit Reached'
                                    : 'On Track',
                                statusColor: totalCals > dailyGoal
                                    ? colorScheme.error
                                    : Colors.green,
                                progressPercentage: progress * 100,
                              ),
                              const SizedBox(height: 16),
                              MacronutrientSummary(
                                protein: protein.toInt(),
                                carbs: carbs.toInt(),
                                fat: fat.toInt(),
                                proteinGoal: 150,
                                carbsGoal: 250,
                                fatGoal: 70,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                        child: Text(
                          'Daily Activity',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),

                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.1,
                            ),
                        delegate: SliverChildListDelegate([
                          _buildMetricCard(
                            'Steps',
                            '${metrics?.steps ?? 0}',
                            Icons.directions_walk,
                            colorScheme.primary,
                            (metrics?.steps ?? 0) / 10000,
                          ),
                          _buildMetricCard(
                            'Heart Rate',
                            '${metrics?.heartRate ?? 0} bpm',
                            Icons.favorite,
                            colorScheme.error,
                            null,
                          ),
                          _buildMetricCard(
                            'Sleep',
                            '${metrics?.sleepHours ?? 0}h',
                            Icons.bedtime,
                            colorScheme.tertiary,
                            (metrics?.sleepHours ?? 0) / 8,
                          ),
                          _buildMetricCard(
                            'Water',
                            '${metrics?.waterGlasses ?? 0} cups',
                            Icons.water_drop,
                            colorScheme.secondary,
                            (metrics?.waterGlasses ?? 0) / 8,
                          ),
                        ]),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 120)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
    double? progress,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              if (progress != null)
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
