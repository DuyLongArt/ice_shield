import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:ice_shield/data_layer/Protocol/Theme/ThemeAdapter.dart';

class ThemeManager {
  static Widget icon(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.palette),
      tooltip: "Change Theme",
      onPressed: () => showThemeSelectionDialog(context),
    );
  }

  static void showThemeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const AutoSizeText('Select Theme', maxLines: 1),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildThemeOption(
                  context,
                  'Default',
                  'assets/DefaultTheme.json',
                ),
                _buildThemeOption(
                  context,
                  'Light Purple',
                  'assets/LightThemePurple.json',
                ),

                _buildThemeOption(
                  context,
                  'Purple Seed',
                  'assets/PurpleSeed.json',
                ),
                const Divider(),
                _buildThemeOption(context, 'Seed Blue', 'assets/SeedBlue.json'),
                _buildThemeOption(
                  context,
                  'Seed Green',
                  'assets/SeedGreen.json',
                ),
                _buildThemeOption(
                  context,
                  'Seed Orange',
                  'assets/SeedOrange.json',
                ),
                _buildThemeOption(
                  context,
                  'Seed Pink (Dark)',
                  'assets/SeedPink.json',
                ),
                _buildThemeOption(context, 'Seed Red', 'assets/SeedRed.json'),
                _buildThemeOption(context, 'Seed Teal', 'assets/SeedTeal.json'),
                _buildThemeOption(
                  context,
                  'Seed Indigo',
                  'assets/SeedIndigo.json',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const AutoSizeText('Cancel', maxLines: 1),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildThemeOption(
    BuildContext context,
    String name,
    String assetPath,
  ) {
    return ListTile(
      title: AutoSizeText(name, maxLines: 1),
      onTap: () {
        // Access ThemeStore and load the selected theme
        Provider.of<ThemeStore>(context, listen: false).loadTheme(assetPath);
        Navigator.of(context).pop();
      },
    );
  }
}
