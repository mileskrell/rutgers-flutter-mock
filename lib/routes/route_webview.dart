import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// This route contains a [WebView] that opens the provided [url] and an [AppBar]
/// that uses the provided [title].
class WebViewRoute extends StatefulWidget {
  final String url;
  final String title;

  const WebViewRoute(this.url, this.title);

  @override
  State<StatefulWidget> createState() => WebViewRouteState();
}

class WebViewRouteState extends State<WebViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
