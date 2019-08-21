import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/widgets/app_widget.dart';

/// The Modules tab in My Apps
class MyAppsModules extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    if (appState.role.modules.isNotEmpty) {
      return ListView.builder(
        itemCount: appState.role.modules.length,
        itemBuilder: (context, index) {
          return AppWidget(appState.role.modules[index]);
        },
      );
    }

    // This shouldn't ever happen
    return Center(
      child: Text("No Modules"),
    );
  }
}
