import 'package:flutter/material.dart';
// import 'package:http/http.dart' as context;
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:ice_shield/data_layer/DomainData/Plugin/GPSTracker/PersonProfile.dart';
import 'package:ice_shield/ui_layer/health_page/models/HealthMetric.dart';
import 'package:ice_shield/ui_layer/health_page/subpage/FoodDashboardPage.dart';
import 'package:ice_shield/ui_layer/health_page/subpage/HeartRatePage.dart';
import 'package:ice_shield/ui_layer/health_page/subpage/SleepPage.dart';
import 'package:ice_shield/ui_layer/health_page/subpage/StepsPage.dart';
import 'package:provider/provider.dart' show ReadContext;

/// Protocol for managing health metrics data
abstract class HealthMetricsProtocol {
  /// Get the current health metrics
  HealthMetrics? getHealthMetrics();

  /// Update health metrics
  Future<bool> updateHealthMetrics(HealthMetrics metrics);

  /// Update specific metric value
  Future<bool> updateMetric(String metricId, dynamic value);

  /// Get metric by ID
  dynamic getMetric(String metricId);

  /// Validate health metrics
  Map<String, String?> validateHealthMetrics(HealthMetrics metrics);
}

/// Default implementation of HealthMetricsProtocol
class HealthMetricsService implements HealthMetricsProtocol {
  HealthMetrics? _currentMetrics;

  HealthMetricsService({HealthMetrics? initialMetrics})
    : _currentMetrics = initialMetrics;

  @override
  HealthMetrics? getHealthMetrics() {
    return _currentMetrics;
  }

  @override
  Future<bool> updateHealthMetrics(HealthMetrics metrics) async {
    // Validate before updating
    final errors = validateHealthMetrics(metrics);
    if (errors.values.any((error) => error != null)) {
      return false;
    }

    // Simulate async operation (e.g., API call or database update)
    await Future.delayed(const Duration(milliseconds: 300));
    _currentMetrics = metrics;
    return true;
  }

  @override
  Future<bool> updateMetric(String metricId, dynamic value) async {
    if (_currentMetrics == null) return false;

    try {
      HealthMetrics updatedMetrics;

      switch (metricId) {
        case 'steps':
          if (value is! int) return false;
          updatedMetrics = _currentMetrics!.copyWith(todaySteps: value);
          break;
        case 'caloriesConsumed':
          if (value is! int) return false;
          updatedMetrics = _currentMetrics!.copyWith(caloriesConsumed: value);
          break;
        case 'caloriesBurned':
          if (value is! int) return false;
          updatedMetrics = _currentMetrics!.copyWith(caloriesBurned: value);
          break;
        case 'sleepHours':
          if (value is! double) return false;
          updatedMetrics = _currentMetrics!.copyWith(sleepHours: value);
          break;
        case 'heartRate':
          if (value is! int) return false;
          updatedMetrics = _currentMetrics!.copyWith(heartRate: value);
          break;
        default:
          return false;
      }

      return await updateHealthMetrics(updatedMetrics);
    } catch (e) {
      return false;
    }
  }

  @override
  dynamic getMetric(String metricId) {
    if (_currentMetrics == null) return null;

    switch (metricId) {
      case 'steps':
        return _currentMetrics!.todaySteps;
      case 'caloriesConsumed':
        return _currentMetrics!.caloriesConsumed;
      case 'caloriesBurned':
        return _currentMetrics!.caloriesBurned;
      case 'sleepHours':
        return _currentMetrics!.sleepHours;
      case 'heartRate':
        return _currentMetrics!.heartRate;
      case 'netCalories':
        return _currentMetrics!.netCalories;
      default:
        return null;
    }
  }

  @override
  Map<String, String?> validateHealthMetrics(HealthMetrics metrics) {
    final errors = <String, String?>{};

    // Validate steps (should be non-negative and reasonable)
    if (metrics.todaySteps < 0) {
      errors['todaySteps'] = 'Steps cannot be negative';
    } else if (metrics.todaySteps > 100000) {
      errors['todaySteps'] = 'Steps value seems unrealistic';
    }

    // Validate calories consumed (should be positive and reasonable)
    if (metrics.caloriesConsumed < 0) {
      errors['caloriesConsumed'] = 'Calories consumed cannot be negative';
    } else if (metrics.caloriesConsumed > 10000) {
      errors['caloriesConsumed'] = 'Calories consumed seems too high';
    }

    // Validate calories burned (should be non-negative and reasonable)
    if (metrics.caloriesBurned < 0) {
      errors['caloriesBurned'] = 'Calories burned cannot be negative';
    } else if (metrics.caloriesBurned > 5000) {
      errors['caloriesBurned'] = 'Calories burned seems too high';
    }

    // Validate sleep hours (should be between 0 and 24)
    if (metrics.sleepHours < 0) {
      errors['sleepHours'] = 'Sleep hours cannot be negative';
    } else if (metrics.sleepHours > 24) {
      errors['sleepHours'] = 'Sleep hours cannot exceed 24';
    }

    // Validate heart rate (should be reasonable)
    if (metrics.heartRate < 30) {
      errors['heartRate'] = 'Heart rate seems too low';
    } else if (metrics.heartRate > 220) {
      errors['heartRate'] = 'Heart rate seems too high';
    }

    return errors;
  }
}

/// Utility class for health metrics data and default values
class HealthMetricsData {
  /// Get default health metrics for display
  static List<HealthMetric> getDefaultMetrics() {
    return [
      const HealthMetric(
        id: 'steps',
        name: 'Steps',
        value: '8,432',
        icon: Icons.directions_walk,
        color: Color(0xFF4CAF50),
        unit: 'steps',
        progress: 0.84,
        subtitle: 'Goal: 10,000',
        trend: '+12%',
        trendPositive: true,
        detailPage: '/health/steps',
      ),
      const HealthMetric(
        id: 'heart_rate',
        name: 'Heart Rate',
        value: '72',
        icon: Icons.favorite,
        color: Color(0xFFE91E63),
        unit: 'bpm',
        subtitle: 'Resting',
        trend: '-3%',
        trendPositive: true,
        detailPage: '/health/heart_rate',
      ),
      const HealthMetric(
        id: 'sleep',
        name: 'Sleep',
        value: '7.5',
        icon: Icons.bedtime,
        color: Color(0xFF673AB7),
        unit: 'hours',
        progress: 0.94,
        subtitle: 'Goal: 8 hours',
        trend: '+0.5h',
        trendPositive: true,
        detailPage: '/health/sleep',
      ),
      const HealthMetric(
        id: 'water',
        name: 'Water',
        value: '6',
        icon: Icons.water_drop,
        color: Color(0xFF2196F3),
        unit: 'glasses',
        progress: 0.75,
        subtitle: 'Goal: 8 glasses',
        trend: '0%',
        trendPositive: null,
      ),
      const HealthMetric(
        id: 'exercise',
        name: 'Exercise',
        value: '45',
        icon: Icons.fitness_center,
        color: Color(0xFFFF5722),
        unit: 'min',
        progress: 0.75,
        subtitle: 'Goal: 60 min',
        trend: '+15min',
        trendPositive: true,
        detailPage: '/health/steps',
      ),
      const HealthMetric(
        id: 'food',
        name: 'Food',
        value: '0',
        icon: Icons.fastfood,
        color: Color(0xFF9C27B0),
        unit: 'kg',
        subtitle: 'Health first',
        trend: '0kg',
        trendPositive: null,
        detailPage: '/health/food/dashboard',
      ),
    ];
  }

  static Future<Map<String, HealthMetric>> getMetricsByDay(
    DateTime day,
    BuildContext context,
  ) async {
    // 1. Get the DAO from the context
    final healthFoodDAO = context.read<HealthMealDAO>();

    // 2. Fetch data from the database
    final healthMetricByDay = await healthFoodDAO.getHealthMetricByDay(day);
    final calories = await healthFoodDAO.getCaloriesByDate(day);
    // 3. Handle the "Empty State" (Important!)
    // If the list is empty, use 0 or a placeholder value
    final String caloriesValue = healthMetricByDay.isNotEmpty
        ? healthMetricByDay[0].meal.calories.toString()
        : '0';

    // 4. Create and return the object directly
    // No need to declare a Future variable here; the 'async' keyword handles it.
    return {
      'food': HealthMetric(
        id: 'food',
        name: 'Food',
        value: calories.toString(),
        icon: Icons.fastfood,
        color: const Color.fromARGB(255, 95, 202, 19),
        unit: 'kcal', // Changed from 'kg' to 'kcal' since it's food!
        subtitle: 'Health first',
        trend: '0kcal',
        trendPositive: null,
        detailPage: '/health/food/dashboard',
      ),
      'steps': HealthMetric(
        id: 'steps',
        name: 'Steps',
        value: caloriesValue,
        icon: Icons.run_circle,
        color: const Color(0xFF9C27B0),
        unit: 'kcal', // Changed from 'kg' to 'kcal' since it's food!
        subtitle: '100 meters define my line',
        trend: '0kcal',
        trendPositive: null,
        detailPage: '/health/steps',
      ),
    };
  }

  /// Get daily summary statistics
  static Map<String, int> getDailySummary() {
    final metrics = getDefaultMetrics();
    int completed = 0;
    int total = 0;

    for (var metric in metrics) {
      if (metric.progress != null) {
        total++;
        if (metric.progress! >= 1.0) {
          completed++;
        }
      }
    }

    return {'completed': completed, 'total': total};
  }
}
