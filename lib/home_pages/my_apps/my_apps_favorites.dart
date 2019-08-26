import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/widgets/app_widget.dart';

/// The Favorites tab in My Apps
class MyAppsFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return appState.favoriteApps.isNotEmpty
        ? AnimatedList(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            initialItemCount: appState.favoriteApps.length,
            itemBuilder: (context, index, animation) {
              return AppWidget(
                appState.favoriteApps[index],
                removeIndex: index,
              );
            },
          )
        : Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "You don't have any favorite apps yet."
                "\n\nAdd some from one of the other pages!",
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
