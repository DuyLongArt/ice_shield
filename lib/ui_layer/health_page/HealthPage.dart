import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//
import 'package:provider/provider.dart';

import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:ice_shield/ui_layer/health_page/HealthMetricCard.dart';
import 'package:ice_shield/ui_layer/health_page/CaloriesMetrics.dart';
import 'package:ice_shield/ui_layer/health_page/models/HealthMetric.dart';
import 'package:ice_shield/data_layer/Protocol/Health/HealthMetricsData.dart';

import 'package:ice_shield/ui_layer/home_page/MainButton.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  // static void _showQuickActions(BuildContext context) {

  //   setState(() {

  //   })
  //   // showModalBottomSheet(
  //   //   context: context,
  //   //   backgroundColor: Colors.transparent,
  //   //   builder: (context) => Container(
  //   //     decoration: BoxDecoration(
  //   //       color: Theme.of(context).colorScheme.surface,
  //   //       borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
  //   //     ),
  //   //     padding: const EdgeInsets.all(24),
  //   //     child: Column(
  //   //       mainAxisSize: MainAxisSize.min,
  //   //       crossAxisAlignment: CrossAxisAlignment.start,
  //   //       children: [
  //   //         Text(
  //   //           'Quick Actions',
  //   //           style: Theme.of(
  //   //             context,
  //   //           ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
  //   //         ),
  //   //         const SizedBox(height: 24),
  //   //         GridView.count(
  //   //           shrinkWrap: true,
  //   //           crossAxisCount: 4,
  //   //           mainAxisSpacing: 16,
  //   //           crossAxisSpacing: 16,
  //   //           children: [
  //   //             _buildQuickActionItem(
  //   //               context,
  //   //               'Log Food',
  //   //               Icons.restaurant,
  //   //               Colors.orange,
  //   //             ),
  //   //             _buildQuickActionItem(
  //   //               context,
  //   //               'Exercise',
  //   //               Icons.fitness_center,
  //   //               Colors.red,
  //   //             ),
  //   //             _buildQuickActionItem(
  //   //               context,
  //   //               'Sleep',
  //   //               Icons.bedtime,
  //   //               Colors.indigo,
  //   //             ),
  //   //             _buildQuickActionItem(
  //   //               context,
  //   //               'Water',
  //   //               Icons.water_drop,
  //   //               Colors.cyan,
  //   //             ),
  //   //           ],
  //   //         ),
  //   //       ),
  //   //     ),
  //   //   );
  // }

  static Widget icon(BuildContext context, {double? size}) {
    return MainButton(
      type: "health",
      destination: "/health",
      size: size,
      mainFunction: () {
        print("Main button clicked");
      },
      icon: Icons.add,
      subButtons: [
        SubButton(
          icon: Icons.restaurant,
          // size: 100,
          backgroundColor: Colors.orange,
          onPressed: () {
            print("Main button clicked");
            context.go('/health/food');
          },
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
          onPressed: () {
            context.go('/health/water');
            print("Water button clicked");
          },
        ),
      ],
      // isShow: false,
      // onPressed: () {
      //   setState(() {
      //     isShow=true;
      //   })
      // },
    );
  }

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  late AppDatabase database;
  Map<String, HealthMetric> _healthMetrics = {};
  bool _isLoading = false;
  late bool compact;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   compact = MediaQuery.of(context).size.width < 1000;
    //   print("======================");
    //   print(compact);
    // });

    database = context.read<AppDatabase>();
    _loadHealthData();
  }

  double _p = 0, _c = 0, _f = 0, _kcal = 0;

  Future<void> _loadHealthData() async {
    setState(() => _isLoading = true);

    try {
      final healthMealDAO = context.read<HealthMealDAO>();
      final today = DateTime.now();

      // Load nutrition daily summary
      final dayMeals = await healthMealDAO.getHealthMetricByDay(today);
      double p = 0, c = 0, f = 0, kcal = 0;
      for (var entry in dayMeals) {
        p += entry.meal.protein;
        c += entry.meal.carbs;
        f += entry.meal.fat;
        kcal += entry.meal.calories;
      }

      final data = await HealthMetricsData.getMetricsByDay(today, context);

      if (mounted) {
        setState(() {
          _healthMetrics = data;
          _p = p;
          _c = c;
          _f = f;
          _kcal = kcal;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading health data: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    compact = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: RefreshIndicator(
        onRefresh: _loadHealthData,
        displacement: 40,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            // Top Padding for status bar if needed, or simple title
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Macro Overview Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _buildMacroOverview(),
              ),
            ),

            // Section Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Insights',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Health Metrics Grid
            _isLoading
                ? const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: compact ? 0.95 : 1.3,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return HealthMetricCard(
                          metrics: _healthMetrics.values.elementAt(index),
                        );
                      }, childCount: _healthMetrics.length),
                    ),
                  ),

            // Bottom padding to avoid FAB overlap
            const SliverToBoxAdapter(child: SizedBox(height: 140)),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroOverview() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NUTRITION TARGET",
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_kcal.toInt()} kcal',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => context.go('/health/food/dashboard'),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.restaurant_rounded,
                    color: colorScheme.primary,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSimpleMacro('Protein', _p, Colors.orange),
              _buildSimpleMacro('Carbs', _c, Colors.blue),
              _buildSimpleMacro('Fat', _f, Colors.pink),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (_kcal / 2000).clamp(0.0, 1.0), // Assuming 2k goal for now
              minHeight: 8,
              backgroundColor: colorScheme.primary.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleMacro(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color.withOpacity(0.8),
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${value.toInt()}g',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
