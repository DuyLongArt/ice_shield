import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:ice_shield/data_layer/Protocol/Home/InternalWidgetProtocol.dart';
import 'package:provider/provider.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/Home/InternalWidgetBlock.dart';
// Note: This import seems redundant: import 'package:ice_shield/orchestration_layer/ActionFiles/Home/InternalWidgetProtocol.dart';
import 'package:ice_shield/security_routing_layer/Routing/navigate_route/WidgetNameMapping.dart';
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:go_router/go_router.dart';
import 'package:ice_shield/ui_layer/home_page/MainButton.dart';
import 'package:auto_size_text/auto_size_text.dart';

// ------------------------------------

class HomePage extends StatefulWidget {
  // We no longer need the local instance here, as it will be read from Provider.
  // InternalWidgetBlock internalWidgetBlock;

  static final WidgetNameMapping _widgetNameMapping = WidgetNameMapping();
  final String title;

  const HomePage({super.key, required this.title});

  static Widget icon(BuildContext context, {double? size}) {
    return MainButton(
      type: "home",
      destination: "/",
      size: size,
      mainFunction: () => {
       context.go("/")
      },
      icon: Icons.ac_unit, // Changed from ice_flower to ac_unit
    );
  }
  static Widget returnHomeIcon(BuildContext context, {double? size}) {
    return MainButton(
      type: "home",
      destination: "/",
      size: size,
      mainFunction: () => {
       context.go("/")
      },
      icon: Icons.home, // Changed from ice_flower to ac_unit
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // CRITICAL FIX: Declare fields that MUST be initialized via context.read
  late AppDatabase database;
  late InternalWidgetBlock internalWidgetBlock;

  @override
  void initState() {
    super.initState();

    // FIX 1: Read the shared instances from the Provider tree.
    // This ensures you are using the same instance created in AdapterLayer.
    database = context.read<AppDatabase>();
    internalWidgetBlock = context.read<InternalWidgetBlock>();

    // Call refresh on the shared block instance.
    internalWidgetBlock.refreshBlock(database.internalWidgetsDAO);
  }

  // NOTE: _loadWidgets is removed as its logic is handled by internalWidgetBlock.refreshBlock

  void _navigateInternalUrl(String name) {
    WidgetNameMapping widgetNameMapping = WidgetNameMapping();

    // print("=============");
    // print(name);
    // Navigator.of(context).push(
    //   MaterialPageRoute<void>(
    //     builder: (context) => widgetNameMapping.getWidgetByName(name),
    //   ),
    // );
    context.go('/$name');
  }

  // --- WIDGET XÂY DỰNG ITEM TRONG GRID (Material Style) ---
  Widget _buildGridItem(
    BuildContext context,
    InternalWidgetProtocol widgetData,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // print(context.read<ThemeAdapter>());

    return Card(
      elevation: 4.0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate font size based on available width
          // Example: 15% of the width, clamped between 12 and 24
          double dynamicFontSize = (constraints.maxWidth * 0.1).clamp(
            10.0,
            20.0,
          );

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  widgetData.name,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: dynamicFontSize,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  minFontSize: 8,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),

                // Nút ElevatedButton
                Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: colorScheme.outline),
                    color: colorScheme.outline,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () => _navigateInternalUrl(widgetData.alias),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      elevation: 2.0,
                    ),
                    child: Icon(widgetData.icon, color: colorScheme.onPrimary),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- QUICK ACCESS CARD FOR PROFILE SECTIONS ---
  Widget _buildQuickAccessCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String subtitle,
    String route,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 4.0,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: () => context.go(route),
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(height: 12),
                AutoSizeText(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  minFontSize: 8,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                AutoSizeText(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  minFontSize: 8,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // print(colorScheme.primary);

    return Scaffold(
      backgroundColor: colorScheme.surface,

      appBar: AppBar(
        title: AutoSizeText(
          widget.title,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          minFontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
        // actions: [SettingsWidget.icon(context)],
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),

          // Use the Observer to react to MobX changes
          child: Watch((context) {
            // Ensure the list isn't null or empty before building
            if (internalWidgetBlock.listInternalWidgetHomePage.value.isEmpty) {
              return const Center(
                child: AutoSizeText('No widgets found.', maxLines: 1),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Dashboard Section
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4.0,
                            vertical: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Wrap your Text in AutoSizeText
                              AutoSizeText(
                                'Life Dashboard',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                                minFontSize:
                                    4, // Prevents it from becoming unreadable
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              TextButton.icon(
                                onPressed: () => context.go('/profile'),
                                icon: Icon(
                                  Icons.arrow_forward,
                                  size: 10,
                                  color: colorScheme.primary,
                                ),
                                label: // Wrap your Text in AutoSizeText
                                AutoSizeText(
                                  'Details',
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                  minFontSize:
                                      4, // Prevents it from becoming unreadable
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 160,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildQuickAccessCard(
                                context,
                                'Health',
                                Icons.favorite,
                                Colors.green,
                                '10,234 steps',
                                '/health',
                              ),
                              _buildQuickAccessCard(
                                context,
                                'Finance',
                                Icons.account_balance_wallet,
                                Colors.blue,
                                '\$5,420',
                                '/finance',
                              ),
                              _buildQuickAccessCard(
                                context,
                                'Social',
                                Icons.people,
                                Colors.purple,
                                '48 friends',
                                '/social',
                              ),
                              _buildQuickAccessCard(
                                context,
                                'Projects',
                                Icons.folder,
                                Colors.orange,
                                '4 active',
                                '/projects',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Section Title for Widgets
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 4.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'Quick Access',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        minFontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  // Original Grid View
                  SizedBox(
                    height: 400, // Fixed height for grid
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.0,
                          ),

                      // Use the block instance read in initState
                      itemCount: internalWidgetBlock
                          .listInternalWidgetHomePage
                          .value
                          .length,
                      itemBuilder: (context, index) {
                        return _buildGridItem(
                          context,
                          internalWidgetBlock
                              .listInternalWidgetHomePage
                              .value[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
