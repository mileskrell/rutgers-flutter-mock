import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/models/app.dart';
import 'package:rutgers_flutter_mock/routes/route_webview.dart';

/// Widget for an "app" in My Apps/My Dashboard
class AppWidget extends StatelessWidget {
  final App app;

  /// If [style] is [AppWidgetStyle.CARD], this must be the index
  /// of the widget in the [AnimatedList] that contains it.
  final int index;

  /// Whether to display as a [Card] (for My Apps)
  /// or just a tile (for My Dashboard)
  final AppWidgetStyle style;

  AppWidget(this.app, {@required this.style, this.index});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    final bool isFavorite = appState.favoriteApps.contains(app);

    final listTile = ListTile(
      title: Text(app.title),
      leading: app.iconData != null
          ? Icon(app.iconData)
          : Image.asset(app.assetString, width: 25),
      trailing: appState.loggedIn
          ? InkWell(
              onTap: () {
                if (isFavorite) {
                  appState.favoriteApps = appState.favoriteApps..remove(app);
                  if (style == AppWidgetStyle.TILE) {
                    AnimatedList.of(context).removeItem(index,
                        (context, animation) {
                      return SizeTransition(
                          sizeFactor: animation,
                          child: AppWidget(
                            app,
                            style: style,
                            index: index,
                          ));
                    });
                  }
                } else {
                  appState.favoriteApps = appState.favoriteApps..add(app);
                  if (style == AppWidgetStyle.TILE) {
                    AnimatedList.of(context).insertItem(index);
                  }
                }
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red.shade900,
              ),
            )
          : null,
    );

    Widget inkWellChild;
    switch (style) {
      case AppWidgetStyle.CARD:
        inkWellChild = Card(
          color: app.inactive ? Colors.grey.shade300 : null,
          child: listTile,
        );
        break;
      case AppWidgetStyle.TILE:
        inkWellChild = Container(
          color: app.inactive ? Colors.grey.shade300 : null,
          child: listTile,
        );
        break;
      default:
        throw "Unknown AppWidgetStyle ${style}";
    }

    return InkWell(
      onTap: () {
        if (app.inactive) {
          showDialog<void>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("\"${app.title}\" is temporarily unavailable"),
                  content: app.inactiveExplanation,
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
                  builder: (context) => WebViewRoute(app.url, app.title)));
        }
      },
      child: inkWellChild,
    );
  }
}

enum AppWidgetStyle {
  CARD,
  TILE,
}
