import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/resources.dart';
import 'package:rutgers_flutter_mock/widgets/app_widget.dart';

/// A [Card] containing the user's favorite apps. Displayed in My Dashboard.
class FavoriteAppsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    final animatedList = AnimatedList(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      initialItemCount: appState.favoriteApps.length,
      itemBuilder: (context, index, animation) {
        return AppWidget(
          appState.favoriteApps[index],
          removeIndex: index,
        );
      },
    );

    return Card(
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text("Favorite Apps", style: TextStyle(color: pantone186)),
        children: appState.favoriteApps.isNotEmpty
            ? [animatedList]
            : [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "You don't have any favorite apps yet."
                    "\n\nAdd some in My Apps!",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
      ),
    );
  }
}
