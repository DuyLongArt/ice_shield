import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ice_shield/initial_layer/Services/Health/AIFoodCaloriesServices.dart';

class FoodInputPage extends StatefulWidget {
  const FoodInputPage({super.key});

  @override
  State<FoodInputPage> createState() => _FoodInputPageState();
}

class _FoodInputPageState extends State<FoodInputPage> {
  final _aiService = Aifoodcaloriesservices();
  bool _isAnalyzing = false;
  final List<Map<String, dynamic>> _meals = [
    {'name': 'Breakfast', 'calories': 450, 'time': '08:30 AM'},
    {'name': 'Lunch', 'calories': 650, 'time': '01:15 PM'},
  ];

  final _foodController = TextEditingController();
  final _caloriesController = TextEditingController();
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _pickedImage = File(image.path);
        });
        // Trigger AI analysis if food name is also present or just analysis from image
        _analyzeFood();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _analyzeFood() async {
    if (_pickedImage == null && _foodController.text.isEmpty) return;

    setState(() => _isAnalyzing = true);

    try {
      final calories = await _aiService.getCalories(
        _foodController.text,
        image: _pickedImage,
      );

      if (mounted) {
        setState(() {
          _caloriesController.text = calories;
          _isAnalyzing = false;
        });
      }
    } catch (e) {
      debugPrint('Error analyzing food: $e');
      if (mounted) setState(() => _isAnalyzing = false);
    }
  }

  void _addMeal() {
    if (_foodController.text.isNotEmpty &&
        _caloriesController.text.isNotEmpty) {
      setState(() {
        _meals.add({
          'name': _foodController.text,
          'calories': int.tryParse(_caloriesController.text) ?? 0,
          'time': 'Just now',
          'image': _pickedImage,
        });
        _foodController.clear();
        _caloriesController.clear();
        _pickedImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    int totalCalories = _meals.fold(
      0,
      (sum, item) => sum + (item['calories'] as int),
    );

    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText('Food Tracker', maxLines: 1),
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
                child: Column(
                  children: [
                    AutoSizeText(
                      'Today\'s Intake',
                      style: textTheme.titleMedium,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8),
                    AutoSizeText(
                      '$totalCalories kcal',
                      style: textTheme.displayMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Goal: 2000 kcal',
                      style: textTheme.bodySmall,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            AutoSizeText(
              'Recent Meals',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _meals.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final meal = _meals[index];
                return ListTile(
                  leading: meal['image'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            meal['image'] as File,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const CircleAvatar(child: Icon(Icons.restaurant)),
                  title: AutoSizeText(meal['name'], maxLines: 1),
                  subtitle: AutoSizeText(meal['time'], maxLines: 1),
                  trailing: AutoSizeText(
                    '+${meal['calories']} kcal',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    maxLines: 1,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMealDialog(context),
        child: const Icon(Icons.camera),
      ),
    );
  }

  void _showAddMealDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Meal'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) => SafeArea(
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Gallery'),
                              onTap: () {
                                _pickImage(ImageSource.gallery).then((_) {
                                  setDialogState(() {});
                                });
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Camera'),
                              onTap: () {
                                _pickImage(ImageSource.camera).then((_) {
                                  setDialogState(() {});
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _pickedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(_pickedImage!, fit: BoxFit.cover),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 40),
                              SizedBox(height: 8),
                              Text('Add Food Photo'),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _foodController,
                  decoration: const InputDecoration(
                    labelText: 'Food Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text) {
                    // Debounce or trigger analysis on focus loss/explicit button might be better,
                    // but for now we can have a button or just a simple trigger.
                  },
                  onEditingComplete: _analyzeFood,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _caloriesController,
                  decoration: InputDecoration(
                    labelText: 'Calories',
                    border: const OutlineInputBorder(),
                    suffixIcon: _isAnalyzing
                        ? const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : IconButton(
                            icon: const Icon(Icons.auto_awesome),
                            onPressed: _analyzeFood,
                            tooltip: 'Analyze Food',
                          ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _pickedImage = null;
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addMeal();
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
