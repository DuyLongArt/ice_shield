import 'package:flutter/material.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/AuthBlock.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/PersonBlock.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:ice_shield/data_layer/Protocol/Home/InternalWidgetProtocol.dart';
import 'package:provider/provider.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/Home/InternalWidgetBlock.dart';
import 'package:ice_shield/security_routing_layer/Routing/navigate_route/WidgetNameMapping.dart';
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:go_router/go_router.dart';
import 'package:ice_shield/ui_layer/home_page/MainButton.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  static Widget icon(BuildContext context, {double? size}) {
    return MainButton(
      type: "home",
      destination: "/",
      size: size,
      mainFunction: () => context.go("/"),
      icon: Icons.ac_unit,
    );
  }

  static Widget returnHomeIcon(BuildContext context, {double? size}) {
    return MainButton(
      type: "home",
      destination: "/",
      size: size,
      mainFunction: () => context.go("/"),
      icon: Icons.ac_unit,
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppDatabase database;
  late InternalWidgetBlock internalWidgetBlock;
  late AuthBlock authBlock;
  late PersonBlock personBlock;

  @override
  void initState() {
    super.initState();
    database = context.read<AppDatabase>();
    internalWidgetBlock = context.read<InternalWidgetBlock>();

    authBlock = context.read<AuthBlock>();
    authBlock.fetchUser();
    personBlock = context.read<PersonBlock>();
    personBlock.fetchFromDatabase(authBlock.jwt.value!);


    // SỬ DỤNG MICROTASK: Đảm bảo không gây lỗi SignalEffectException khi khởi tạo
    Future.microtask(() {
      internalWidgetBlock.refreshBlock(database.internalWidgetsDAO);
    });
  }

  void _navigateInternalUrl(String name) {
    context.go('/$name');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Watch((context) {
        final widgets = internalWidgetBlock.listInternalWidgetHomePage.value;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SECTION: LIFE DASHBOARD ---
              _buildSectionHeader(context, 'Life Dashboard', '/profile'),
              const SizedBox(height: 8),
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
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

              const SizedBox(height: 32),

              // --- SECTION: QUICK ACCESS GRID ---
              AutoSizeText(
                'Quick Access',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),

              if (widgets.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: AutoSizeText('No widgets found.', maxLines: 1),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true, // Cho phép Grid co giãn theo nội dung
                  physics:
                      const NeverScrollableScrollPhysics(), // Scroll theo SingleChildScrollView
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio:
                        0.9, // Chỉnh lại tỷ lệ để text không bị đè
                  ),
                  itemCount: widgets.length,
                  itemBuilder: (context, index) =>
                      _buildGridItem(context, widgets[index]),
                ),

              const SizedBox(height: 40), // Padding cuối trang
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, String route) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
        TextButton.icon(
          onPressed: () => context.go(route),
          icon: const Icon(Icons.arrow_forward, size: 16),
          label: const Text('Details'),
        ),
      ],
    );
  }

  Widget _buildQuickAccessCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String subtitle,
    String route,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: color.withOpacity(0.2)),
        ),
        child: InkWell(
          onTap: () => context.go(route),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color, size: 20),
                ),
                const Spacer(),
                AutoSizeText(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                AutoSizeText(
                  subtitle,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    InternalWidgetProtocol widgetData,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => _navigateInternalUrl(widgetData.alias),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widgetData.icon, color: colorScheme.primary, size: 30),
            const SizedBox(height: 8),
            AutoSizeText(
              widgetData.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
