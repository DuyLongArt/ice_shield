// Required for ImageFilter
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:ice_shield/ui_layer/home_page/MainButton.dart';
import 'package:ice_shield/ui_layer/widget_page/AddPluginForm.dart';
import 'package:ice_shield/ui_layer/widget_page/WidgetPage.dart';
import 'package:provider/provider.dart';

// --- IMPORTS ---
// 1. The Data Protocol
import 'package:ice_shield/orchestration_layer/ReactiveBlock/Canvas/WidgetManagerBlock.dart';
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

class DragCanvasGrid extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Neumorphic colors usually need a slight adjustment from the base surface
    // to make the highlights pop.
    final baseColor = colorScheme.surface;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final widgetDao = context.read<WidgetDAO>();
    final personBlock = context.read<PersonBlock>();

    // Create a signal that extracts the ID from the personBlock information
    final personIdSignal = computed(
      () => personBlock.information.value.profiles.id,
    );

    return Provider<WidgetManagerBlock>(
      create: (_) => WidgetManagerBlock(
        widgetDao: widgetDao,
        personIdSignal: personIdSignal,
      ),
      dispose: (_, block) => block.dispose(),
      child: Scaffold(
        backgroundColor: baseColor, // Match scaffold to surface
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
        // HEADER
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.ltr,
            children: [
              Text(
                "CANVAS",
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              WidgetPage.icon(),

              // Reset Button (Neumorphic)
            ],
          ),
        ),

        // MAIN GRID
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: widget.baseColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.1),
              ),
            ),
            child: Watch((context) {
              // final width = MediaQuery.of(context).size.width;
              // final height = MediaQuery.of(context).size.height;

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: widgetBlock.widgets.length,
                itemBuilder: (context, index) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      // print(constraints.maxWidth);
                      return Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // iconSize: constraints.maxWidth/4,
                            // iconSize: constraints.maxWidth/2,
                            padding: EdgeInsets.zero,
                            fixedSize: Size(
                              constraints.maxWidth,
                              constraints.maxHeight,
                            ),
                            backgroundColor: const Color.fromARGB(
                              0,
                              255,
                              255,
                              255,
                            ),
                          ),
                          onPressed: () {
                            buildAddCell(context);
                          },
                          child: InternalDragIconWidget(
                            index: index,
                            store: widgetBlock,
                            widthCard: constraints.maxWidth,
                            heightCard: constraints.maxHeight,
                          ),
                          // ),
                        ),
                      );
                    },
                  );
                },
              );
            }),
          ),
        ),

        const SizedBox(height: 16),

        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  widgetBlock.resetGrid();
                  // setState(() {
                  setState(() {
                    isClick = !isClick;
                  });

                  // });
                },

                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  // width: 20,
                  height: 30,
                  // width: 48,
                  // height: 48,
                  // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: isClick
                        ? widget.baseColor
                        : widget.baseColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).dividerColor.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // LIBRARY / STORE
        // const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
        const SizedBox(height: 2),
        const StoreWidget(),
      ],
    );
  }
}
