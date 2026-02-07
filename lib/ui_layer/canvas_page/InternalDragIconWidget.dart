// / --- DRAG TARGET (GRID CELL) ---
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../data_layer/Protocol/Canvas/InternalWidgetDragProtocol.dart';
// import '../../data_layer/Protocol/Widget/InternalWidgetDragProtocol.dart';
// import '../../data_layer/Protocol/Widget/WidgetManagerBlock.dart';
// import '../BigWidget/Canvas/StoreWidget.dart';
import '../../orchestration_layer/ReactiveBlock/Canvas/WidgetManagerBlock.dart';
import 'StoreWidget.dart';
// import '../../data_layer/Protocol/Widget/InternalWidgetDragProtocol.dart';
// import '../../data_layer/Protocol/Widget/WidgetManagerBlock.dart';

class InternalDragIconWidget extends StatefulWidget {
  final int index;
  final WidgetManagerBlock store;

  const InternalDragIconWidget({
    super.key,
    required this.index,
    required this.store,
    required this.widthCard,
    required this.heightCard,
  });

  final double widthCard;
  final double heightCard;

  @override
  State<InternalDragIconWidget> createState() => _InternalDragIconWidgetState();
}

class _InternalDragIconWidgetState extends State<InternalDragIconWidget> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    // OBSERVER: Rebuilds specific cell if its specific data changes
    return Watch((context) {
      // Get current data from store
      final InternalWidgetDragProtocol cellData =
          widget.store.widgets[widget.index];
      final bool isEmpty = cellData.name == 'Empty';

      // Decide what we accept
      return DragTarget(
        onWillAcceptWithDetails: (details) {
          setState(() => isHovering = true);
          return true;
        },
        onLeave: (_) => setState(() => isHovering = false),
        onAcceptWithDetails: (details) {
          setState(() => isHovering = false);

          final incomingData = details.data;

          if (incomingData is int) {
            // Case A: Dragging from another Grid Cell (Int Index)
            widget.store.handleInteraction(incomingData, widget.index);
            print("Widget from inside");
          } else if (incomingData is InternalWidgetDragProtocol) {
            print("Widget from outside");
            widget.store.addWidget(widget.index, incomingData);
          }
        },
        builder: (context, candidateData, rejectedData) {
          final Color borderColor = isHovering
              ? Colors.cyanAccent
              : Colors.white.withOpacity(0.1);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isEmpty
                  ? Colors.white.withOpacity(0.05)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(
                16,
              ), // Matched to new card radius
              border: Border.all(color: borderColor, width: isHovering ? 2 : 1),
              boxShadow: isHovering
                  ? [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: isEmpty
                ? const Center(
                    child: Icon(Icons.add_rounded, color: Colors.white24),
                  )
                : Draggable<int>(
                    // We pass the INDEX, not the object, to track where it came from
                    data: widget.index,
                    feedback: Material(
                      color: Colors.transparent,
                      child: Transform.scale(
                        scale: 1.1,
                        child: BuildCard(
                          item: cellData,
                          isDragging: true,
                          cardWidth: widget.widthCard / 2,
                          cardHeight: widget.heightCard / 2,
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      width: widget.widthCard,
                      height: widget.heightCard,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Stack(
                      children: [
                        BuildCard(
                          item: cellData,
                          cardWidth: widget.widthCard,
                          cardHeight: widget.heightCard,
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: InkWell(
                            onTap: () {
                              widget.store.removeByIndex(widget.index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white24,
                                  width: 0.5,
                                ),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.close_rounded,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      );
    });
  }
}
