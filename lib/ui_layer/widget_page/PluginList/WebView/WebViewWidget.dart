import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as wv;
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class EmbeddedWebViewWidget extends StatefulWidget {
  final String url;
  final bool showControls;

  const EmbeddedWebViewWidget({
    super.key,
    required this.url,
    this.showControls = true,
  });

  @override
  State<EmbeddedWebViewWidget> createState() => _EmbeddedWebViewWidgetState();
}

class _EmbeddedWebViewWidgetState extends State<EmbeddedWebViewWidget> {
  late final wv.WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Initialize the controller with platform-specific params
    late final wv.PlatformWebViewControllerCreationParams params;
    if (wv.WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
      );
    } else {
      params = const wv.PlatformWebViewControllerCreationParams();
    }

    final wv.WebViewController controller =
        wv.WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(wv.JavaScriptMode.unrestricted)
      //this will make errors
      // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        wv.NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onWebResourceError: (wv.WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    // setBackgroundColor is not supported on macOS
    if (defaultTargetPlatform != TargetPlatform.macOS) {
      controller.setBackgroundColor(const Color(0x00000000));
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        wv.WebViewWidget(controller: _controller),
        if (_isLoading) const Center(child: CircularProgressIndicator()),
        if (widget.showControls)
          Positioned(
            bottom: 8,
            right: 8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.refresh, size: 20),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(8),
                  ),
                  onPressed: () => _controller.reload(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
