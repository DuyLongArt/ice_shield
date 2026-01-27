import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// Helper function to convert a hex string (e.g., "0xFF3F3B66") to a Color object.
Color _parseColor(String hex) {
  // 1. Trim whitespace from start/end.
  String cleanHex = hex.trim();

  // 2. Remove non-hex characters (optional, but robust against BOM/control characters)
  // This replaces anything that isn't 0-9, A-F, a-f, or 0x/0X with an empty string.
  cleanHex = cleanHex.replaceAll(RegExp(r'[^\dA-Fa-f0-9xX]'), '');

  // 3. Ensure it starts with '0x' if the original JSON used the full ARGB format.
  if (!cleanHex.startsWith('0x')) {
    cleanHex = '0x$cleanHex';
  }

  try {
    // 4. Parse the cleaned string with radix 16 (which is automatic with '0x')
    return Color(int.parse(cleanHex));
  } catch (e) {
    // Helpful debug during error:
    print('Failed to parse color string: "$cleanHex"');
    rethrow;
  }
}

// Helper function to parse a string weight ("bold", "medium", "normal") to FontWeight
FontWeight _parseFontWeight(String weight) {
  switch (weight.toLowerCase()) {
    case 'bold':
      return FontWeight.bold;
    case 'medium':
      return FontWeight.w500;
    case 'light':
      return FontWeight.w300;
    default:
      return FontWeight.normal;
  }
}

// Helper function to parse a string brightness ("light", "dark") to Brightness
Brightness _parseBrightness(String brightness) {
  return brightness.toLowerCase() == 'dark'
      ? Brightness.dark
      : Brightness.light;
}

class JsonThemeAdapter {
  // Static method to load and parse the theme from an asset file
  static Future<ThemeData> loadThemeFromAsset(String assetPath) async {
    final jsonString = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    // --- 1. Parse Core ColorScheme ---
    final Map<String, dynamic> colorsJson = jsonMap['color_scheme'] ?? {};
    final Brightness brightness = _parseBrightness(
      jsonMap['brightness'] ?? 'light',
    );

    ColorScheme colorScheme;

    // Check for 'seed_color' to use Material 3 generation
    if (jsonMap.containsKey('seed_color')) {
      final Color seedColor = _parseColor(jsonMap['seed_color']);
      colorScheme = ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
        // You can still override specific colors if they are provided in color_scheme
        primary: colorsJson.containsKey('primary')
            ? _parseColor(colorsJson['primary'])
            : null,
        onPrimary: colorsJson.containsKey('onPrimary')
            ? _parseColor(colorsJson['onPrimary'])
            : null,
        secondary: colorsJson.containsKey('secondary')
            ? _parseColor(colorsJson['secondary'])
            : null,
        onSecondary: colorsJson.containsKey('onSecondary')
            ? _parseColor(colorsJson['onSecondary'])
            : null,
        surface: colorsJson.containsKey('surface')
            ? _parseColor(colorsJson['surface'])
            : null,
        onSurface: colorsJson.containsKey('onSurface')
            ? _parseColor(colorsJson['onSurface'])
            : null,
        error: colorsJson.containsKey('error')
            ? _parseColor(colorsJson['error'])
            : null,
        onError: colorsJson.containsKey('onError')
            ? _parseColor(colorsJson['onError'])
            : null,
      );
    } else {
      // Fallback to manual definition
      colorScheme = ColorScheme(
        brightness: brightness,
        primary: _parseColor(colorsJson['primary'] ?? '0xFF000000'),
        onPrimary: _parseColor(colorsJson['onPrimary'] ?? '0xFFFFFFFF'),
        secondary: _parseColor(colorsJson['secondary'] ?? '0xFF000000'),
        onSecondary: _parseColor(colorsJson['onSecondary'] ?? '0xFFFFFFFF'),
        surface: _parseColor(colorsJson['surface'] ?? '0xFFFFFFFF'),
        onSurface: _parseColor(colorsJson['onSurface'] ?? '0xFF000000'),
        error: _parseColor(colorsJson['error'] ?? '0xFFB00020'),
        onError: _parseColor(colorsJson['onError'] ?? '0xFFFFFFFF'),
        // Add other ColorScheme properties if defined in JSON
      );
    }

    // --- 2. Parse TextTheme ---
    final Map<String, dynamic> textThemeJson = jsonMap['text_theme'] ?? {};
    final String fontFamily = textThemeJson['fontFamily'] ?? 'Roboto';

    // Helper to create a TextStyle from a JSON key
    TextStyle createTextStyle(Map<String, dynamic> styleJson) {
      if (styleJson.isEmpty) return const TextStyle();
      return TextStyle(
        fontFamily: fontFamily,
        fontSize: (styleJson['size'] as num?)?.toDouble(),
        fontWeight: _parseFontWeight(styleJson['weight'] ?? 'normal'),
        color: styleJson['color'] != null
            ? _parseColor(styleJson['color'])
            : null,
      );
    }

    // Create the final TextTheme (simplified to include only defined keys)
    final TextTheme textTheme = TextTheme(
      headlineLarge: createTextStyle(textThemeJson['headlineLarge'] ?? {}),
      bodyMedium: createTextStyle(textThemeJson['bodyMedium'] ?? {}),
      labelLarge: createTextStyle(
        textThemeJson['labelLarge'] ?? {},
      ), // Used for buttons
      // Add other required text styles here (titleLarge, bodySmall, etc.)
    );

    // --- 3. Parse Component Themes ---
    final Map<String, dynamic> componentsJson = jsonMap['components'] ?? {};

    // AppBar Theme
    final Map<String, dynamic> appBarJson = componentsJson['appBar'] ?? {};
    final AppBarTheme appBarTheme = AppBarTheme(
      backgroundColor: appBarJson['backgroundColor'] != null
          ? _parseColor(appBarJson['backgroundColor'])
          : colorScheme.primary,
      foregroundColor: appBarJson['foregroundColor'] != null
          ? _parseColor(appBarJson['foregroundColor'])
          : colorScheme.onPrimary,
      elevation: (appBarJson['elevation'] as num?)?.toDouble() ?? 4.0,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: appBarJson['foregroundColor'] != null
            ? _parseColor(appBarJson['foregroundColor'])
            : colorScheme.onPrimary,
      ),
    );

    // ElevatedButton Theme
    final Map<String, dynamic> buttonJson =
        componentsJson['elevatedButton'] ?? {};
    final ButtonStyle elevatedButtonStyles = ElevatedButton.styleFrom(
      backgroundColor: buttonJson['backgroundColor'] != null
          ? _parseColor(buttonJson['backgroundColor'])
          : colorScheme.primary,
      foregroundColor: buttonJson['foregroundColor'] != null
          ? _parseColor(buttonJson['foregroundColor'])
          : colorScheme.onPrimary,
      elevation: (buttonJson['elevation'] as num?)?.toDouble() ?? 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          (buttonJson['borderRadius'] as num?)?.toDouble() ?? 4.0,
        ),
      ),
      textStyle: textTheme.labelLarge, // Apply parsed labelLarge style
    );

    // --- 4. Final ThemeData Construction ---
    return ThemeData(
      useMaterial3: jsonMap['useMaterial3'] ?? true, // Set Material 3 flag
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,

      // Apply Component Themes
      appBarTheme: appBarTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyles),
      // Add other component themes (FloatingActionButtonTheme, CardTheme, etc.) here

      // Explicitly set primaryColor and accentColor for backward compatibility (optional)
      primaryColor: colorScheme.primary,

      // accentColor is deprecated, use colorScheme.secondary
    );
  }
}
