import 'package:flutter/material.dart';
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class FoodDashboardPage extends StatefulWidget {
  const FoodDashboardPage({super.key});

  @override
  State<FoodDashboardPage> createState() => _FoodDashboardPageState();
}

class _FoodDashboardPageState extends State<FoodDashboardPage> {
  late HealthMealDAO _healthMealDAO;
  String? _appDirPath;

  @override
  void initState() {
    super.initState();
    // Khởi tạo thư mục ứng dụng một lần duy nhất
    _initStorage();
  }

  Future<void> _initStorage() async {
    final dir = await getApplicationDocumentsDirectory();
    if (mounted) {
      setState(() {
        _appDirPath = dir.path;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _healthMealDAO = context.read<HealthMealDAO>();
  }

  // Nhóm các bữa ăn theo ngày
  Map<String, List<DayWithMeal>> _groupMealsByDay(List<DayWithMeal> meals) {
    final Map<String, List<DayWithMeal>> grouped = {};
    for (var meal in meals) {
      final dateKey = DateFormat('yyyy-MM-dd').format(meal.meal.eatenAt);
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(meal);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Nutrition Tracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<List<DayWithMeal>>(
        stream: _healthMealDAO.watchDaysWithMeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return const Center(
              child: Text('No meals logged yet. Start tracking!'),
            );
          }

          final groupedMeals = _groupMealsByDay(data);
          final sortedDays = groupedMeals.keys.toList()
            ..sort((a, b) => b.compareTo(a));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sortedDays.length,
            itemBuilder: (context, index) {
              final dateKey = sortedDays[index];
              final dayMeals = groupedMeals[dateKey]!;
              return _buildDayCard(dateKey, dayMeals);
            },
          );
        },
      ),
    );
  }

  Widget _buildDayCard(String dateKey, List<DayWithMeal> dayMeals) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    double p = 0, c = 0, f = 0, kcal = 0;
    for (var entry in dayMeals) {
      p += entry.meal.protein;
      c += entry.meal.carbs;
      f += entry.meal.fat;
      kcal += entry.meal.calories;
    }

    final date = DateTime.parse(dateKey);
    final isToday = DateFormat('yyyy-MM-dd').format(DateTime.now()) == dateKey;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          // Header của ngày
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isToday
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isToday ? 'Today' : DateFormat('EEEE, MMM d').format(date),
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${kcal.toInt()} kcal',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Tóm tắt dinh dưỡng
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMacroSummary('Protein', p, Colors.orange),
                _buildMacroSummary('Carbs', c, Colors.blue),
                _buildMacroSummary('Fat', f, Colors.pink),
              ],
            ),
          ),
          const Divider(height: 1),
          // Danh sách món ăn trong ngày
          ...dayMeals.map((meal) => _buildMealRow(meal)),
        ],
      ),
    );
  }

  Widget _buildMealRow(DayWithMeal entry) {
    final meal = entry.meal;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _buildMealImage(meal.mealImageUrl, 60),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.mealName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat('h:mm a').format(meal.eatenAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildMacroChip('P', meal.protein, Colors.orange),
                    const SizedBox(width: 4),
                    _buildMacroChip('C', meal.carbs, Colors.blue),
                    const SizedBox(width: 4),
                    _buildMacroChip('F', meal.fat, Colors.pink),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '${meal.calories.toInt()}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMealImage(String? imageName, double size) {
    if (_appDirPath == null || imageName == null || imageName.isEmpty) {
      return Container(
        width: size,
        height: size,
        color: Colors.grey[200],
        child: const Icon(Icons.restaurant, color: Colors.grey),
      );
    }

    final file = File('$_appDirPath/$imageName');
    return Image.file(
      file,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: size,
        height: size,
        color: Colors.grey[200],
        child: const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );
  }

  Widget _buildMacroSummary(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          '${value.toInt()}g',
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: color.withOpacity(0.7)),
        ),
      ],
    );
  }

  Widget _buildMacroChip(String label, double value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label: ${value.toInt()}g',
        style: TextStyle(fontSize: 9, color: color),
      ),
    );
  }
}
