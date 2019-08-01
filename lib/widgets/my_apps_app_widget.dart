import 'package:flutter/material.dart';

import 'package:rutgers_basic_flutter_mock/routes/route_webview.dart';

class App extends StatelessWidget {
  final String title;
  final String url;

  final IconData iconData;
  final String assetString;

  App(
      {@required this.title,
      @required this.url,
      this.iconData,
      this.assetString}) {
    if (title == null || url == null) {
      throw "Title and URL are both required";
    }

    if (iconData == null && assetString == null) {
      throw "Either icon data or asset string must be provided when creating an App widget";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<Null>(
                builder: (context) => WebViewRoute(url, title)));
      },
      child: Card(
        child: ListTile(
            title: Text(title),
            leading: iconData != null
                ? Icon(iconData)
                : Image.asset(
                    assetString,
                    width: 25,
                  )),
      ),
    );
  }
}
