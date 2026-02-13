import 'package:flutter/material.dart';
import 'package:ice_shield/data_layer/Protocol/Canvas/ExternalWidgetProtocol.dart';
import 'package:provider/provider.dart';
import '../../data_layer/DataSources/local_database/Database.dart';
import 'PluginList/AvailablePlugins.dart';
import '../../data_layer/Protocol/Plugin/BasePluginProtocol.dart';

// --- DATA MODEL ---
class FormData {
  final String title;
  String? description;
  final String name;

  FormData({required this.title, this.description, this.name = 'Add Widget'});
}

// --- MAIN WIDGET ---
// --- MAIN WIDGET ---
class AddPluginForm extends StatefulWidget {
  final FormData data;

  const AddPluginForm({super.key, required this.data});

  @override
  State<AddPluginForm> createState() => _WidgetFormDataState();
}

class _WidgetFormDataState extends State<AddPluginForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  late ExternalWidgetsDAO databaseDAO;

  // Plugin selection state
  bool _isPluginMode = true; // true = plugin list, false = custom URL
  BasePluginProtocol? _selectedPlugin;

  @override
  void initState() {
    super.initState();
    databaseDAO = context.read<ExternalWidgetsDAO>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  Map<String, String> _parseUrl(String url) {
    Uri? uri = Uri.tryParse(url);
    if (uri != null && uri.hasAuthority) {
      return {
        'protocol': uri.scheme.isNotEmpty ? uri.scheme : 'https',
        'host': uri.host.isNotEmpty ? uri.host : 'N/A',
        'url': uri.path + (uri.query.isNotEmpty ? '?${uri.query}' : ''),
      };
    } else {
      return {'protocol': 'https', 'host': 'N/A', 'url': url};
    }
  }

  void _handleSubmit() {
    if (_isPluginMode) {
      // Plugin mode - use selected plugin
      if (_selectedPlugin == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Please select a plugin")));
        return;
      }

      final ExternalWidgetProtocol protocol = ExternalWidgetProtocol(
        name: _selectedPlugin!.name,
        protocol: _selectedPlugin!.protocol,
        host: _selectedPlugin!.host,
        url: _selectedPlugin!.url,
        imageUrl: _selectedPlugin!.imageUrl,
        dateAdded: DateTime.now().toIso8601String(),
      );

      databaseDAO.insertNewWidget(externalWidgetProtocol: protocol);
    } else {
      // Custom URL mode
      final String name = _nameController.text.trim();
      final String urlText = _urlController.text.trim();

      if (name.isEmpty || urlText.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill in all fields")),
        );
        return;
      }

      final Map<String, String> parsedData = _parseUrl(urlText);

      final ExternalWidgetProtocol protocol = ExternalWidgetProtocol(
        name: name,
        protocol: parsedData['protocol'] ?? "https",
        host: parsedData['host'] ?? "",
        url: parsedData['url'] ?? "",
        imageUrl: "",
        dateAdded: DateTime.now().toIso8601String(),
      );

      databaseDAO.insertNewWidget(externalWidgetProtocol: protocol);
    }

    _nameController.clear();
    _urlController.clear();
    setState(() {
      _selectedPlugin = null;
    });

    Navigator.of(context).pop();
  }

  // Input Decoration - simulating "pressed" or "concave" look with simple styling
  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey[600]),
      filled: true,
      // fillColor: Colors.grey[200], // Slightly darker to look recessed
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (widget.data.description != null)
                  Text(
                    widget.data.description!,
                    // style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                const SizedBox(height: 24),

                // Mode Toggle
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isPluginMode = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _isPluginMode
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.apps,
                                  size: 18,
                                  color: _isPluginMode
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Plugins',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _isPluginMode
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimary
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isPluginMode = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: !_isPluginMode
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.link,
                                  size: 18,
                                  color: !_isPluginMode
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Custom URL',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: !_isPluginMode
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimary
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Content based on mode
                if (_isPluginMode)
                  // Plugin Grid
                  SizedBox(
                    height: 300,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.2,
                          ),
                      itemCount: AvailablePlugins.all.length,
                      itemBuilder: (context, index) {
                        final plugin = AvailablePlugins.all[index];
                        final isSelected = _selectedPlugin == plugin;

                        return GestureDetector(
                          onTap: () => setState(() => _selectedPlugin = plugin),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer
                                  : Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  plugin.icon,
                                  size: 28,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  plugin.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    plugin.description,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  // Custom URL Form
                  Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: _inputDecoration(
                          'Widget Name (e.g. Facebook)',
                          Icons.label_outline,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _urlController,
                        decoration: _inputDecoration(
                          'URL (e.g. facebook.com)',
                          Icons.link,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 24),

                // Submit Button
                GestureDetector(
                  onTap: _handleSubmit,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.3),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    // child: Center(
                      child: Center(
                        // padding: const EdgeInsets.symmetric(horizontal: 8),
                        // constraints: BoxConstraints.tight(Size.square(16)),
                        child: const Text(
                        "Add Widget",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        // ),
                    
                        )  ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
