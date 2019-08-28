import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/models/app.dart';
import 'package:rutgers_flutter_mock/routes/route_webview.dart';

/// Widget for an "app" in My Apps/My Dashboard
///
/// TODO: Maybe add an "info" button to this widget, like on my.rutgers.edu
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
                title: Text("${app.title} is temporarily unavailable"),
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
          Navigator.push(context, MaterialPageRoute<Null>(
            builder: (context) {
              if (app.url != null) {
                return WebViewRoute(app.url, app.title);
              } else {
                final moduleData =
                    "data:text/html,<!DOCTYPE html><p>This would open the ${app.title} module</p>";
                return WebViewRoute(moduleData, app.title);
              }
            },
          ));
        }
      },
      child: Container(
        color: app.inactive ? Colors.grey.shade300 : null,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(app.title),
              subtitle: app.isNew
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: app.inactive
                                ? Colors.grey.shade600
                                : Colors.green,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 4,
                            ),
                            child: Text(
                              "New",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  : null,
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
                          appState.favoriteApps = appState.favoriteApps
                            ..add(app);
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
            )
          ],
        ),
      ),
    );
  }
}
