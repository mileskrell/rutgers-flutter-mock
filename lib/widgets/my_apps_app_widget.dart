import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/routes/route_webview.dart';
import 'package:rutgers_flutter_mock/widgets/link_text.dart';

/// Widget for an "app" in My Apps.
///
/// TODO: Rename this to reflect that it's just for links
///
/// TODO: Add widgets to open built-in modules (e.g. bus, maps)
///
/// TODO: Maybe add an "info" button to this widget, like on my.rutgers.edu
class App extends StatelessWidget {
  final String title;
  final String url;

  final IconData iconData;
  final String assetString;
  final bool inactive;
  final LinkText inactiveExplanation;

  App(
      {@required this.title,
      @required this.url,
      this.iconData,
      this.assetString,
      this.inactive = false,
      this.inactiveExplanation}) {
    if (title == null || url == null) {
      throw "App \"$title\" must provide both a title and URL";
    }

    if (iconData == null && assetString == null) {
      throw "App \"$title\" must provide either icon data or asset string";
    }

    if (inactive && inactiveExplanation == null) {
      throw "Inactive app \"$title\" must provide a reason for being inactive";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (inactive) {
          showDialog<void>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("\"$title\" is temporarily unavailable"),
                  content: inactiveExplanation,
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Close"),
                    ),
                  ],
                );
              });
        } else {
          Navigator.push(
              context,
              MaterialPageRoute<Null>(
                  builder: (context) => WebViewRoute(url, title)));
        }
      },
      child: Card(
        color: inactive ? Colors.grey.shade300 : null,
        child: ListTile(
          title: Text(title),
          leading: iconData != null
              ? Icon(iconData)
              : Image.asset(assetString, width: 25),
          trailing:
              inactive ? Icon(Icons.error, color: Colors.red.shade900) : null,
        ),
      ),
    );
  }
}
