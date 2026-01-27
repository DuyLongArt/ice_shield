import 'package:flutter/material.dart';
import 'WebViewWidget.dart';

class WebViewPage extends StatelessWidget {
  final String url;
  final String title;

  const WebViewPage({super.key, required this.url, this.title = 'Web View'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), elevation: 0),
      body: EmbeddedWebViewWidget(url: url, showControls: true),
    );
  }
}
