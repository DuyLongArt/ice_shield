import 'package:flutter/material.dart';
import 'package:ice_shield/data_layer/Protocol/Health/HealthMetricsData.dart';
import 'package:ice_shield/initial_layer/FireAPI/UrlNavigate.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/Home/InternalWidgetBlock.dart'
    show InternalWidgetBlock;
// import 'package:ice_shield/initial_layer/FireAPI/UrlNavigate.dart' as WidgetNavigatorAction;
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/AuthBlock.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/PersonBlock.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/Widgets/ScoreBlock.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/Widgets/ScoreData.dart';
import 'package:ice_shield/ui_layer/health_page/models/HealthMetric.dart';
import 'package:ice_shield/orchestration_layer/Action/WebView/WebViewPage.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/GrowthBlock.dart';
import 'package:ice_shield/data_layer/Protocol/Home/InternalWidgetProtocol.dart';
import 'package:provider/provider.dart';
import 'package:ice_shield/security_routing_layer/Routing/navigate_route/WidgetNameMapping.dart';
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:go_router/go_router.dart';
import 'package:ice_shield/ui_layer/home_page/MainButton.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ice_shield/ui_layer/widget_page/AddPluginForm.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/Home/ExternalWidgetBlock.dart';
import 'package:ice_shield/orchestration_layer/Action/WidgetNavigator.dart';

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
  late HealthMetricsDAO healthMetricsDAO;
  late Map<String, HealthMetric> healthMetricsData = {};
  late ScoreBlock scoreBlock;
  late ExternalWidgetBlock externalWidgetBlock;
  late GrowthBlock growthBlock;

  @override
  void initState() {
    super.initState();
    database = context.read<AppDatabase>();
    internalWidgetBlock = context.read<InternalWidgetBlock>();
    externalWidgetBlock = context.read<ExternalWidgetBlock>();
    authBlock = context.read<AuthBlock>();
    scoreBlock = context.read<ScoreBlock>();
    authBlock.fetchUser();
    personBlock = context.read<PersonBlock>();
    growthBlock = context.read<GrowthBlock>();
    healthMetricsDAO = database.healthMetricsDAO;

    final jwtValue = authBlock.jwt.value;
    if (jwtValue != null) {
      personBlock.fetchFromDatabase(jwtValue);
    }

    Future.microtask(() {
      internalWidgetBlock.refreshBlock(database.internalWidgetsDAO);
      externalWidgetBlock.refreshBlock(database.externalWidgetsDAO);
      HealthMetricsData.getMetricsByDay(DateTime.now(), context).then((
        newData,
      ) {
        if (mounted) {
          setState(() {
            healthMetricsData = newData;
          });
        }
      });
    });
  }

  void _navigateInternalUrl(String name) {
    context.go('/$name');
  }

  void _showAddPluginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: AddPluginForm(
          data: FormData(
            title: "Add App Plugin",
            description: "Choose a plugin to extend your dashboard",
          ),
        ),
      ),
    );
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
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
          maxLines: 1,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundColor: colorScheme.primaryContainer.withOpacity(0.5),
              child: Icon(
                Icons.person_outline,
                color: colorScheme.primary,
                size: 20,
              ),
            ),
            onPressed: () => context.go('/profile'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Watch((context) {
        final internalWidgets =
            internalWidgetBlock.listInternalWidgetHomePage.value;
        final externalWidgets = externalWidgetBlock.listExternalWidgets.value;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SECTION: GAMIFIED HEADER ---
              _buildGamifiedHeader(context),
              const SizedBox(height: 24),

              // --- SECTION: LIFE DASHBOARD ---
              _buildSectionHeader(context, 'Life Dashboard', '/profile'),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildQuickAccessCard(
                      context,
                      'Health',
                      Icons.favorite_rounded,
                      Colors.green,
                      '${healthMetricsData['steps']?.value ?? 0} steps • ${healthMetricsData['food']?.value ?? 0} kcal',
                      '/health',
                      scoreBlock.score.healthGlobalScore,
                    ),
                    _buildQuickAccessCard(
                      context,
                      'Finance',
                      Icons.account_balance_wallet_rounded,
                      Colors.blue,
                      '\$5,420 • Up 12%',
                      '/finance',
                      scoreBlock.score.financialGlobalScore,
                    ),
                    _buildQuickAccessCard(
                      context,
                      'Social',
                      Icons.people_alt_rounded,
                      Colors.purple,
                      '48 friends • 3 new',
                      '/social',
                      scoreBlock.score.socialGlobalScore,
                    ),
                    Watch((context) {
                      final projectGoals = growthBlock.goals.value
                          .where((g) => g.category == 'project')
                          .toList();
                      final activeCount = projectGoals
                          .where((g) => g.status != 'done')
                          .length;
                      final doneCount = projectGoals
                          .where((g) => g.status == 'done')
                          .length;

                      return _buildQuickAccessCard(
                        context,
                        'Projects',
                        Icons.rocket_launch_rounded,
                        Colors.orange,
                        '$activeCount active • $doneCount done',
                        '/projects',
                        scoreBlock.score.careerGlobalScore,
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // --- SECTION: QUICK ACCESS GRID ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    'Quick Access',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                    maxLines: 1,
                  ),
                  TextButton(onPressed: () {}, child: const Text('Edit')),
                ],
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(right: 20),
                  itemCount:
                      internalWidgets.length + externalWidgets.length + 1,
                  itemBuilder: (context, index) {
                    if (index < internalWidgets.length) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SizedBox(
                          width: 110,
                          child: _buildGridItem(
                            context,
                            internalWidgets[index],
                          ),
                        ),
                      );
                    } else if (index <
                        internalWidgets.length + externalWidgets.length) {
                      final ext =
                          externalWidgets[index - internalWidgets.length];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SizedBox(
                          width: 110,
                          child: _buildExternalGridItem(context, ext),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: 110,
                        child: _buildGridItem(context, null, isAddButton: true),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 32),

              // --- SECTION: RECENT ACTIVITY ---
              AutoSizeText(
                'Recent Insights',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),

              // Placeholder for insights
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: colorScheme.primary.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      color: colorScheme.primary,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Smart Tip',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'You\'ve been 20% more active this week. Keep it up!',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildGamifiedHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final level = scoreBlock.globalLevel.value;
    final progress = scoreBlock.levelProgress.value;
    final rank = scoreBlock.rankTitle.value;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withOpacity(0.8),
            colorScheme.primary.withOpacity(0.6),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: colorScheme.onPrimary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rank.toUpperCase(),
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.9),
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Level $level',
                    style: textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.onPrimary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.shield_rounded,
                  color: colorScheme.onPrimary,
                  size: 26,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress to Level ${level + 1}',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.85),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, String route) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
          maxLines: 1,
        ),
        TextButton.icon(
          onPressed: () => context.go(route),
          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
          label: const Text('View All'),
          style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
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
    double scoreData,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 5),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: color.withOpacity(0.1)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.go(route),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.12), color.withOpacity(0.02)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(icon, color: color, size: 24),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),

                        child: Column(
                          children: [
                            Text(
                              "LV ${(scoreData / 100).floor() + 1}",
                              style: TextStyle(
                                color: color,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "P: ${(scoreData).toStringAsFixed(1)}",
                              style: TextStyle(
                                color: color,
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AutoSizeText(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (scoreData % 100) / 100,
                      backgroundColor: color.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AutoSizeText(
                    subtitle,
                    style: TextStyle(
                      color: color.withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    InternalWidgetProtocol? widgetData, {
    bool isAddButton = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    if (isAddButton) {
      return InkWell(
        onTap: () => _showAddPluginDialog(context),
        borderRadius: BorderRadius.circular(28),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.2),
              width: 2,
              style: BorderStyle
                  .none, // Can change to solid for dashed effect if custom painter
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add_rounded,
                  color: colorScheme.primary,
                  size: 30,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Add Plugin',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (widgetData == null) return const SizedBox.shrink();

    return InkWell(
      onTap: () => _navigateInternalUrl(widgetData.url),
      borderRadius: BorderRadius.circular(28),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: colorScheme.outlineVariant.withOpacity(0.4),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                widgetData.icon,
                color: colorScheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 10),
            AutoSizeText(
              widgetData.name,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExternalGridItem(BuildContext context, ExternalWidgetData data) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        final String fullUrl = "${data.protocol}://${data.host}${data.url}";
        print("Opening external widget: $fullUrl");
        // navigateExternalUrl(fullUrl);
        WidgetNavigatorAction.navigateExternalUrl(context, fullUrl);
        // navigateExternalUrl(context, fullUrl);
      },
      borderRadius: BorderRadius.circular(28),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: colorScheme.outlineVariant.withOpacity(0.4),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.language_rounded,
                color: Colors.blueAccent,
                size: 28,
              ),
            ),
            const SizedBox(height: 10),
            AutoSizeText(
              data.name,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateExternalUrl(String fullUrl) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => WebViewPage(url: fullUrl)));
  }
}
