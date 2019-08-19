import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/routes/route_webview.dart';

/// A class that allows embedding links in text.
/// To use it, provide a list of [String] and [Link] as [children].
class LinkText extends StatelessWidget {
  final List<Object> children;

  const LinkText({@required this.children})
      : assert(children != null, "Elements cannot be null");

  @override
  Widget build(BuildContext context) {
    final spans = children.map((it) {
      if (it is String) {
        return TextSpan(
          style: TextStyle(color: Colors.black),
          text: it,
        );
      }
      if (it is Link) {
        return TextSpan(
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            text: it.text,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (context) {
                  return WebViewRoute(it.url, it.linkTitle);
                }));
              });
      }

      throw "Element $it is not String or Link";
    }).toList();

    return RichText(text: TextSpan(children: spans));
  }
}

class Link {
  final String text;
  final String url;
  final String linkTitle;

  const Link(
      {@required this.text, @required this.url, @required this.linkTitle});
}
