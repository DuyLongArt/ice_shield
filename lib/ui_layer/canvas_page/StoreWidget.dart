import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// --- IMPORTS ---
// Update these paths to match your actual project structure
import '../../../data_layer/DataSources/local_database/Database.dart';
// import '../../../data_layer/Protocol/Widget/InternalWidgetDragProtocol.dart';
// import '../../../data_layer/Protocol/Widget/WidgetManagerBlock.dart';
import '../../data_layer/Protocol/Canvas/InternalWidgetDragProtocol.dart';
import 'package:ice_shield/orchestration_layer/Action/WidgetNavigator.dart';
import '../../initial_layer/FireAPI/UrlNavigate.dart'; // Added for navigation
import '../widget_page/AddPluginForm.dart';
// import '../WidgetCard.dart'; // We will use BuildCard exclusively for the store to ensure consistent dragging size

import 'package:flutter/services.dart';

class StoreWidget extends StatelessWidget {
  const StoreWidget({super.key});

  // 1. STATIC DEFAULTS
  List<InternalWidgetDragProtocol> _getDefaultItems() {
    return [
      InternalWidgetDragProtocol.item(
        name: "Facebook",
        color: "0xFF1877F2",
        url: 'https://facebook.com',
        imageUrl: '',
        alias: 'facebook',
        dateAdded: DateTime.now().toIso8601String(),
        widgetID: 101,
        score: 10,
      ),
      InternalWidgetDragProtocol.item(
        name: "Instagram",
        color: "0xFFE1306C",
        url: 'https://instagram.com',
        imageUrl: '',
        alias: 'instagram',
        dateAdded: DateTime.now().toIso8601String(),
        widgetID: 102,
        score: 10,
      ),
      InternalWidgetDragProtocol.item(
        name: "Phone",
        color: "0xFF34C759",
        url: 'tel:',
        imageUrl: '',
        alias: 'phone',
        dateAdded: DateTime.now().toIso8601String(),
        widgetID: 103,
        score: 5,
      ),
      InternalWidgetDragProtocol.item(
        name: "Messages",
        color: "0xFF007AFF",
        url: 'sms:',
        imageUrl: '',
        alias: 'messages',
        dateAdded: DateTime.now().toIso8601String(),
        widgetID: 104,
        score: 50,
      ),
      InternalWidgetDragProtocol.item(
        name: "Mail",
        color: "0xFFEA4335",
        url: 'mailto:',
        imageUrl: '',
        alias: 'mail',
        dateAdded: DateTime.now().toIso8601String(),
        widgetID: 105,
        score: 20,
      ),
    ];
  }

  // 2. CONVERTER (Database -> Drag Protocol)
  InternalWidgetDragProtocol _protocolToDragProtocol(ExternalWidgetData data) {
    return InternalWidgetDragProtocol.item(
      name: data.name ?? 'Unknown',
      color: "0xFF607D8B",
      url: "${data.protocol}://${data.host}${data.url}",
      imageUrl: "${data.protocol}://${data.host}${data.url}",
      alias: 'plugin',
      dateAdded: DateTime.now().toIso8601String(),
      widgetID: int.tryParse(data.widgetID.toString()) ?? 0,
      score: 5,
      isTarget: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dao = context.read<ExternalWidgetsDAO>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Container(
        height: 125,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: StreamBuilder<List<ExternalWidgetData>>(
            stream: dao.watchAllWidgets(),
            builder: (context, snapshot) {
              final List<InternalWidgetDragProtocol> combinedList =
                  _getDefaultItems();

              if (snapshot.hasData && snapshot.data != null) {
                final externalItems = snapshot.data!
                    .map((data) => _protocolToDragProtocol(data))
                    .toList();
                combinedList.addAll(externalItems);
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: combinedList.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 20),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildAddButton(context);
                  }

                  final item = combinedList[index - 1];

                  return Draggable<InternalWidgetDragProtocol>(
                    data: item,
                    onDragStarted: () => HapticFeedback.lightImpact(),
                    feedback: Material(
                      color: Colors.transparent,
                      child: Transform.scale(
                        scale: 1.15,
                        child: BuildCard(
                          item: item,
                          isDragging: true,
                          cardWidth: 85,
                          cardHeight: 85,
                          name: item.name,
                        ),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.1,
                      child: BuildCard(
                        item: item,
                        cardWidth: 85,
                        cardHeight: 85,
                        name: item.name,
                      ),
                    ),
                    child: BuildCard(
                      item: item,
                      cardWidth: 85,
                      cardHeight: 85,
                      name: item.name,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      onTap: () => showAddWidgetDialog(context),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "New",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- CARD RENDERER ---
class BuildCard extends StatelessWidget {
  final InternalWidgetDragProtocol item;
  final bool isDragging;
  final double cardWidth;
  final double cardHeight;
  final String name;

  const BuildCard({
    super.key,
    required this.item,
    this.isDragging = false,
    required this.cardWidth,
    required this.cardHeight,
    required this.name,
  });

  Color _getColor(String hexString) {
    try {
      return Color(int.parse(hexString));
    } catch (e) {
      return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(item.color);
    final isIconOnly = item.alias != 'plugin';

    return Hero(
      tag: 'widget_${item.widgetID}_${item.name}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (item.url.isNotEmpty) {
              if (item.alias.contains("plugin")) {
                WidgetNavigatorAction.navigateExternalUrl(context, item.url);
              } else {
                urlNavigate(item.url);
              }
            }
          },
          borderRadius: BorderRadius.circular(24),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(1.0), color.withOpacity(0.8)],
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
                if (!isDragging)
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, -1),
                  ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isIconOnly)
                  Icon(_getIcon(item.alias), color: Colors.white, size: 28)
                else
                  _buildFavicon(),
                const SizedBox(height: 8),
                AutoSizeText(
                  name,
                  maxLines: 1,
                  minFontSize: 8,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String alias) {
    switch (alias.toLowerCase()) {
      case 'facebook':
        return Icons.facebook_rounded;
      case 'instagram':
        return Icons.camera_alt_rounded;
      case 'phone':
        return Icons.call_rounded;
      case 'messages':
        return Icons.textsms_rounded;
      case 'mail':
        return Icons.alternate_email_rounded;
      default:
        return Icons.link_rounded;
    }
  }

  Widget _buildFavicon() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white30, width: 0.5),
      ),
      padding: const EdgeInsets.all(4),
      child: ClipOval(
        child: Image.network(
          'https://www.google.com/s2/favicons?sz=64&domain=${item.url}',
          width: 24,
          height: 24,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.public_rounded, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

void showAddWidgetDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: AddPluginForm(
        data: FormData(
          title: "Add Custom Widget",
          description: "Enter the name and URL of the website you want to add.",
        ),
      ),
    ),
  );
}
