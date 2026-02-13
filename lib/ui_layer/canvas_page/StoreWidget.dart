import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// --- IMPORTS ---
// Update these paths to match your actual project structure
import '../../../data_layer/DataSources/local_database/Database.dart';
// import '../../../data_layer/Protocol/Widget/InternalWidgetDragProtocol.dart';
// import '../../../data_layer/Protocol/Widget/WidgetManagerBlock.dart';
import '../../data_layer/Protocol/Canvas/InternalWidgetDragProtocol.dart';
import '../../initial_layer/FireAPI/UrlNavigate.dart'; // Added for navigation
import '../widget_page/AddPluginForm.dart';
// import '../WidgetCard.dart'; // We will use BuildCard exclusively for the store to ensure consistent dragging size

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
      // Use a distinct color for external items or a default
      color: "0xFF607D8B",
      url: "${data.protocol}://${data.host}${data.url}",
      imageUrl:
          "${data.protocol}://${data.host}${data.url}", // Use URL as image source for favicons
      alias: 'plugin', // specific alias to trigger image logic
      dateAdded: DateTime.now().toIso8601String(),
      widgetID: int.tryParse(data.widgetID.toString()) ?? 0,
      score: 5,
      isTarget: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dao = context.read<ExternalWidgetsDAO>();

    return Container(
      height:
          MediaQuery.sizeOf(context).height *
          0.13, // Slightly taller for better spacing
      // padding: const EdgeInsets.only(top: 50, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3), // Semi-transparent background
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      // margin: const EdgeInsets.only(top: 50, bottom: 20),

      // 3. UNIFIED STREAM BUILDER
      // This listens to the DB. When DB changes, the list updates automatically.
      child: StreamBuilder<List<ExternalWidgetData>>(
        stream: dao.watchAllWidgets(),
        builder: (context, snapshot) {
          // A. Start with the Default items
          /// change from external to internal widget right? =
          final List<InternalWidgetDragProtocol> combinedList =
              _getDefaultItems();

          // B. Add Database items if they exist
          if (snapshot.hasData && snapshot.data != null) {
            final externalItems = snapshot.data!
                .map((data) => _protocolToDragProtocol(data))
                .toList();
            combinedList.addAll(externalItems);
          }

          // C. Render One Unified List
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            // padding: const EdgeInsets.all(16),
            // margin: const EdgeInsets.all(16),
            itemCount: combinedList.length + 1, // +1 for Add Button

            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                  onTap: () => showAddWidgetDialog(context),
                  borderRadius: BorderRadius.circular(16),

                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      // color: Colors.white.withOpacity(0.1),
                      // border: Border.all(color: Colors.white),
                      // borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        // SizedBox(height: 4),
                        Text(
                          "Add New",
                          style: TextStyle(color: Colors.white, fontSize: 9),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final item = combinedList[index - 1]; // Adjust index

              return Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.03,
                  bottom: 10,
                ),
                width: MediaQuery.sizeOf(context).height * 0.08,
                child: Draggable<InternalWidgetDragProtocol>(
                  // Logic: IDGen in the Grid will handle creating a unique ID upon drop
                  data: item,

                  feedback: Material(
                    // color: Colors.transparent,
                    child: Transform.scale(
                      scale: 1.0,
                      child: BuildCard(
                        item: item,
                        isDragging: true,
                        cardWidth: MediaQuery.sizeOf(context).height * 0.08,
                        cardHeight: MediaQuery.sizeOf(context).height * 0.08,
                        name: item.name,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: BuildCard(
                          item: item,
                          cardWidth: 80,
                          cardHeight: 80,
                          name: item.name,
                        ),
                      ),
                      // Text(item.name, style: TextStyle(color: Colors.white, fontSize: 9),)
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// --- CARD RENDERER ---
class BuildCard extends StatelessWidget {
  final InternalWidgetDragProtocol item;
  final bool isDragging;

  const BuildCard({
    super.key,
    required this.item,
    this.isDragging = false,
    required this.cardWidth,
    required this.cardHeight,
    required this.name,
  });

  final double cardWidth;
  final double cardHeight;
  final String name;

  // 1. Icon Logic for Default Items
  IconData _getIcon(String alias) {
    switch (alias.toLowerCase()) {
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt;
      case 'phone':
        return Icons.phone;
      case 'messages':
        return Icons.message;
      case 'mail':
        return Icons.email;
      default:
        return Icons.link_rounded; // Default icon for external links
    }
  }

  // 2. Image/Favicon Logic for External Items
  Widget _buildContent(BuildContext context) {
    // If it's an external item (marked by alias or url presence)

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Attempt to load Google Favicon
          Container(
            // color: Colors.red,
            decoration: BoxDecoration(
              // color: Colors.white,
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                'https://www.google.com/s2/favicons?sz=64&domain=${item.url}',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.public, color: Colors.white);
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(item.name, style: TextStyle(color: Colors.white, fontSize: 9)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),

            child: (MediaQuery.sizeOf(context).height < 400)
                ? AutoSizeText(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : (Container()),
          ),
        ],
      ),
    );
  }

  // Default Internal Items
  //  Column(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: [
  //     Icon(_getIcon(item.alias), color: Colors.white, size: 32),
  //     const SizedBox(height: 8),
  //     Text(
  //       item.name,
  //       style: const TextStyle(
  //         color: Colors.white,
  //         fontWeight: FontWeight.w600,
  //         fontSize: 12,
  //         shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
  //       ),
  //     ),
  //     if (item.score > 0)
  //       Text(
  //         "${item.score}",
  //         style: const TextStyle(color: Colors.white70, fontSize: 10),
  //       ),
  //   ],
  // );

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

    return Card(
      elevation: isDragging ? 12 : 4,
      shadowColor: color.withOpacity(0.5),
      color: Colors.transparent,
      margin: EdgeInsets.zero, // Remove default margin
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          if (item.url.isNotEmpty) {
            // print("Navigating to: ${item.url}");
            // print("alias: ${item.alias}");
            if (item.alias.contains("plugin")) {
              navigateExternalUrl(context, item.url);
              // print("DuyLongTest: ${item.url}");
            } else {
              urlNavigate(item.url);
            }
            //  "${widgetData.protocol}://${widgetData.host}${widgetData.url}";
            print("Navigating to: ${item.url}");
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          // width: 100, // Removed fixed width
          // height: 100, // Removed fixed height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: _buildContent(context),
        ),
      ),
    );
  }
}

void showAddWidgetDialog(BuildContext context) {
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
