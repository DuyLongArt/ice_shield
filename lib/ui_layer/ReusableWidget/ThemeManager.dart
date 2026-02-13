import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:provider/provider.dart';
import 'package:ice_shield/data_layer/Protocol/Theme/ThemeAdapter.dart';
import 'package:ice_shield/initial_layer/CurrentThemeData.dart';

class ThemeManager {
  static Widget icon(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.palette),
      tooltip: "Change Theme",
      onPressed: () => {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            showThemeSelectionDialog(context);
          }
        }),
      },
    );
  }

  static void showThemeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final width = MediaQuery.of(context).size.width;
        return Align(
          alignment: Alignment.center, // Keeps it strictly centered
          // child: Material( // Required for elevation/styling when not using AlertDialog
          //   color: Colors.transparent,
          child: Container(
            width: width * 0.5,

            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const SizedBox(height: 16),
                _buildThemeOption(
                  context,
                  'Emerald Haven',
                  'assets/DefaultTheme.json',
                ),
                _buildThemeOption(
                  context,
                  'Cyberpunk 2077',
                  'assets/Cyberpunk.json',
                ),
                _buildThemeOption(
                  context,
                  'Midnight Gold',
                  'assets/MidnightGold.json',
                ),
                _buildThemeOption(context, 'Deep Sea', 'assets/DeepSea.json'),
                _buildThemeOption(
                  context,
                  'Frosty Morning',
                  'assets/Frosty.json',
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
              // ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildThemeOption(
    BuildContext context,
    String name,
    String assetPath,
  ) {
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
      child: Container(width: width * 0.5, child: Text(name, maxLines: 1)),

      onPressed: () {
        Provider.of<ThemeStore>(context, listen: false).loadTheme(assetPath);
        ThemeDAO themeDAO = ThemeDAO(context.read<AppDatabase>());
        themeDAO.saveCurrentTheme(CurrentThemeData(themePath: assetPath));

        // var currentThemeData = themeDAO.getCurrentTheme();
        // printCurrentThemeData(context);
        Navigator.of(context).pop();
      },
    );
  }
}
