// Required for ImageFilter
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:ice_shield/ui_layer/home_page/MainButton.dart';
import 'package:ice_shield/ui_layer/widget_page/AddPluginForm.dart';
import 'package:ice_shield/ui_layer/widget_page/WidgetPage.dart';
import 'package:provider/provider.dart';

// --- IMPORTS ---
// 1. The Data Protocol
import 'package:ice_shield/orchestration_layer/ReactiveBlock/Canvas/WidgetManagerBlock.dart';
import 'package:go_router/go_router.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/PersonBlock.dart';
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'InternalDragIconWidget.dart'; // The Grid Cell
import 'StoreWidget.dart'; // The Bottom Bar

// --- MAIN SCREEN WRAPPER ---

void buildAddCell(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      // backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: AddPluginForm(
        data: FormData(
          title: "Add Custom Widget",
          description: "Enter the name and URL of the website you want to add.",
        ),
      ),
    ),
  );
}

class DragCanvasGrid extends StatefulWidget {
  const DragCanvasGrid({super.key});

  static Widget icon(BuildContext context, {double? size}) {
    return MainButton(
      type: "grid",
      destination: "/canvas",
      size: size,
      icon: Icons.add,
      mainFunction: () => buildAddCell(context),
    );
  }

  @override
  State<DragCanvasGrid> createState() => _DragCanvasGridState();
}

class _DragCanvasGridState extends State<DragCanvasGrid> {
  late final ReadonlySignal<int?> personIdSignal;
  late final WidgetManagerBlock widgetManagerBlock;

  @override
  void initState() {
    super.initState();
    final personBlock = context.read<PersonBlock>();
    final widgetDao = context.read<WidgetDAO>();

    personIdSignal = computed(() => personBlock.information.value.profiles.id);

    widgetManagerBlock = WidgetManagerBlock(
      widgetDao: widgetDao,
      personIdSignal: personIdSignal,
    );
  }

  @override
  void dispose() {
    widgetManagerBlock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final baseColor = colorScheme.surface;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Provider<WidgetManagerBlock>.value(
      value: widgetManagerBlock,
      child: Scaffold(
        backgroundColor: baseColor,
        body: SafeArea(
          bottom: false,
          child: DragCanvas(baseColor: baseColor, isDark: isDark),
        ),
      ),
    );
  }
}

class DragCanvas extends StatefulWidget {
  final Color baseColor;
  final bool isDark;

  const DragCanvas({super.key, required this.baseColor, required this.isDark});

  @override
  State<DragCanvas> createState() => _DragCanvasState();
}

class _DragCanvasState extends State<DragCanvas> {
  bool isClick = false;
  // late WidgetManagerBlock widgetBlock;

  @override
  void initState() {
    super.initState();
    // Chạy sau khi build xong để tránh SignalEffectException
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WidgetManagerBlock>().loadFromDatabase();
      print("======================");
      print(context.read<WidgetManagerBlock>().widgets);
    });
  }

  @override
  Widget build(BuildContext context) {
    // listen: false vì chúng ta đã dùng Watch để quản lý các phần thay đổi
    final widgetBlock = Provider.of<WidgetManagerBlock>(context, listen: false);
    return Column(
      children: [
        const SizedBox(height: 12),
        // DYNAMIC ISLAND
        Center(
          child: Container(
            width: 140,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      context.go('/');
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const AutoSizeText(
                  "CANVAS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  ),
                 
                ),
                // WidgetPage.icon(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),

        // MAIN GRID (iPhone 16 Proportions)
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              color: widget.baseColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(35),
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.03),
              ),
            ),
            child: Watch((context) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: widgetBlock.widgets.length,
                itemBuilder: (context, index) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return InternalDragIconWidget(
                        index: index,
                        store: widgetBlock,
                        widthCard: constraints.maxWidth,
                        heightCard: constraints.maxHeight,
                        name: widgetBlock.widgets[index].name,
                      );
                    },
                  );
                },
              );
            }),
          ),
        ),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  widgetBlock.resetGrid();
                  setState(() => isClick = !isClick);
                },
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text("Reset Layout"),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.7),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),
        ),

        // LIBRARY / STORE
        // const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
        const SizedBox(height: 2),
        const StoreWidget(),
      ],
    );
  }
}
