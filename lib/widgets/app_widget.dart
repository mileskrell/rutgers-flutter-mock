import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/models/app.dart';
import 'package:rutgers_flutter_mock/routes/route_webview.dart';

/// Widget for an "app" in My Apps/My Dashboard
class AppWidget extends StatelessWidget {
  final App app;

  /// The [AppWidget]'s index in its parent [AnimatedList]
  /// (if contained in one).
  ///
  /// Set this to remove the widget from its parent when un-favorited.
  ///
  /// **This will throw an exception if the parent is not an [AnimatedList].**
  final int removeIndex;

  AppWidget(this.app, {this.removeIndex});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    final bool isFavorite = appState.favoriteApps.contains(app);

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
            },
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute<Null>(
                builder: (context) => WebViewRoute(app.url, app.title),
              ));
        }
      },
      child: Container(
        color: app.inactive ? Colors.grey.shade300 : null,
        child: ListTile(
          title: Text(app.title),
          leading: app.iconData != null
              ? Icon(app.iconData)
              : Image.asset(app.assetString, width: 25),
          trailing: appState.loggedIn
              ? IconButton(
                  onPressed: () {
                    if (isFavorite) {
                      appState.favoriteApps = appState.favoriteApps
                        ..remove(app);
                      if (removeIndex != null) {
                        AnimatedList.of(context).removeItem(
                          removeIndex,
                          (context, animation) => SizeTransition(
                            sizeFactor: animation,
                            child: AppWidget(app, removeIndex: removeIndex),
                          ),
                        );
                      }
                    } else {
                      appState.favoriteApps = appState.favoriteApps..add(app);
                      if (removeIndex != null) {
                        // Won't ever happen with the current UI
                        AnimatedList.of(context).insertItem(removeIndex);
                      }
                    }
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red.shade900,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
