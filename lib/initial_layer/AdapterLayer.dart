import 'package:flutter/material.dart';
// NOTE: Please ensure these imports are correct for your project structure
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/Home/InternalWidgetBlock.dart';
// import 'package:ice_shield/orchestration_layer/ActionFiles/Home/InternalWidgetProtocol.dart';
import 'package:ice_shield/data_layer/Protocol/Theme/ThemeAdapter.dart';
// import 'package:ice_shield/security_routing_layer/Routing/navigate_route/WidgetNameMapping.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/AuthBlock.dart';
import 'package:ice_shield/initial_layer/Services/CustomAuthService.dart';
import 'package:provider/provider.dart';

class Adapter extends StatefulWidget {
  final Widget childWidget;

  const Adapter({super.key, required this.childWidget});

  @override
  State<Adapter> createState() => _adapterState();
}

class _adapterState extends State<Adapter> {
  ThemeData? themeData;
  late ThemeStore themeStore;

  // FIX 1: Initialize the MobX block here to avoid the "Field not initialized" error.
  InternalWidgetBlock internalWidgetBlock = InternalWidgetBlock();
  late AuthBlock authBlock;

  late AppDatabase appDatabase;

  // NOTE: internalWidgetHomeData is not used correctly in the build/providers
  // and is omitted here to avoid adding more errors.
  // late List<InternalWidgetProtocol> internalWidgetHomeData;

  // FIX 2: Check for existing data before inserting defaults.
  void _initAsyncDatabaseLink() async {
    final dao = appDatabase.internalWidgetsDAO;

    // Check if default data ("HomePage") already exists.
    final existingWidget = await dao.getInternalWidgetByName("WidgetPage");

    if (existingWidget == null) {
      // Insert default data only if it doesn't exist.
      await dao.insertInternalWidget(
        name: "WidgetPage",
        imageUrl: "",
        url: "/canvas",
        // widgetID: 1
        alias: "WidgetPage",
      );

      await dao.insertInternalWidget(
        name: "Health Department",
        imageUrl: "",
        url: "/health",
        alias: "HealthPage",
        // widgetID: 1
      );

      // print("Default internal widgets inserted successfully.");
    } else {
      print("Default internal widgets already exist. Skipping insertion.");
    }

    // Start the reactive stream after data insertion is complete.
    internalWidgetBlock.refreshBlock(dao);
  }

  @override
  void initState() {
    super.initState();

    // Get the AppDatabase instance from the Provider context.
    // This assumes AppDatabase is provided in a widget above 'Adapter'.
    appDatabase = context.read<AppDatabase>();

    // Start the async initialization (data insertion and stream setup).
    _initAsyncDatabaseLink();

    // Access themeStore from parent
    themeStore = context.read<ThemeStore>();

    // Initialize AuthBlock with CustomAuthService and SessionDAO
    authBlock = AuthBlock(
      authService: CustomAuthService(baseUrl: 'https://backend.duylong.art'),
      sessionDao: appDatabase.sessionDAO,
    );
    authBlock.checkSession(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 1. ThemeStore is already provided by ThemeLayer

        // 2. Provide the MobX InternalWidgetBlock
        Provider<InternalWidgetBlock>.value(value: internalWidgetBlock),

        // 4. Provide the static utility class
        Provider<ThemeAdapter>(create: (_) => ThemeAdapter()),

        // 5. Provide the AuthBlock
        Provider<AuthBlock>.value(value: authBlock),
      ],
      // Pass control to the child (MyApp) via widget.childWidget
      child: widget.childWidget,
    );
  }
}
