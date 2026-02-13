import 'package:flutter/material.dart';
import 'package:ice_shield/ui_layer/health_page/HealthPage.dart';
import 'package:ice_shield/ui_layer/user_page/HunterInformationPage.dart';
// NOTE: Make sure to import the actual path to your InternalWidget
import 'package:ice_shield/ui_layer/widget_page/WidgetPage.dart';
// Assuming all necessary widgets are imported or defined below.

// Define a type for the factory function: a function that returns a Widget,
// accepting an optional String parameter (for dynamic data like a route name).
typedef WidgetFactory = Widget Function({String? identifier});

class WidgetNameMapping {
  // --- 1. THE DICTIONARY (STATIC MAP) ---
  // Stores the name (String) and a function (WidgetFactory) to create the Widget.
  static final Map<String, WidgetFactory> _widgetMap = {
    // 1. Base Widget Page: Returns a standard instance.
    'WidgetPage': ({identifier}) => WidgetPage(),
    "UserInformationPage": ({identifier}) => UserInformationPage(),
    "HealthPage": ({identifier}) => HealthPage(),
    // 2. Example of another specific Widget
    // 'SettingsWidget': ({identifier}) => const SettingsWidget(),

    // Add more widget mappings here...
  };
  // ------------------------------------

  // --- 2. Get Widget by Single Name ---
  // Now uses the map for efficient lookup.
  Widget getWidgetByName(String name) {
    // 1. Look up the factory function in the map.
    final widgetFactory = _widgetMap[name];

    if (widgetFactory != null) {
      // 2. If found, call the function and return the created Widget.
      // We pass the name itself as the identifier, just in case the widget needs it.
      return widgetFactory(identifier: name);
    } else {
      // 3. If not found, return the fallback Error404Widget.
      return Error404Widget(routeName: name);
    }
  }

  // --- 3. Get List of InternalWidgets by List of Names ---
  // NOTE: This implementation is still logically flawed (converting Widget to InternalWidget),
  // but it maintains your original intent to return a List<InternalWidget>.
  List<Widget> getWidgetByListName(List<String> listName) {
    List<Widget> widgetList = listName
        .map((name) => _widgetMap[name]!(identifier: name))
        .toList();
    return widgetList;
  }
}

// --- 4. Concrete Error404Widget Implementation (Unchanged) ---
class Error404Widget extends StatelessWidget {
  final String routeName;

  const Error404Widget({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error 404'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: Colors.red),
              const SizedBox(height: 20),
              const Text(
                'Widget Not Found',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'The widget route "$routeName" could not be resolved.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
