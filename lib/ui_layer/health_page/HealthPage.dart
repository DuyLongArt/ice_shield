import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//
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

  Future<void> _loadHealthData() async {
    setState(() => _isLoading = true);

    // Simulate loading delay for smooth animation
    await Future.delayed(const Duration(milliseconds: 500));

    // final calories = await _healthMealDAO.getCaloriesByDate(DateTime.now());
    final data = await HealthMetricsData.getMetricsByDay(
      DateTime.now(),
      context,
    );
    setState(() {
      _healthMetrics = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final summary = HealthMetricsData.getDailySummary();
    compact = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Watch((context) {
        return RefreshIndicator(
          onRefresh: _loadHealthData,
          child: CustomScrollView(
            slivers: [
              // Header Section
              SliverToBoxAdapter(
                child: HealthPageHeader(
                  completedGoals: summary['completed'] ?? 0,
                  totalGoals: summary['total'] ?? 0,
                ),
              ),

              // Spacing
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Featured Calorie Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                ),
              ),

              // Spacing
              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // Health Metrics Section Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Health Metrics',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ),

              // Spacing
              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Health Metrics Grid
              _isLoading
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: CircularProgressIndicator(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: compact?16:64,
                          
                          mainAxisSpacing: compact?24:48,
                          childAspectRatio: compact ? 1 : 1.6,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return HealthMetricCard(
                            metrics: _healthMetrics.values.elementAt(index),
                          );
                        }, childCount: _healthMetrics.length),
                      ),
                    ),

              // Bottom padding
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        );
      }),
    );
  }
}
