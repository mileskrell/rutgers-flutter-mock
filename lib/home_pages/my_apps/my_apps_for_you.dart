import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/models/app_category.dart';
import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/widgets/app_category_widget.dart';

/// The "For You" tab in My Apps
class MyAppsForYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    if (appState.role.appCategories.isNotEmpty) {
      return ListView.builder(
        itemCount: appState.role.appCategories.length,
        itemBuilder: (context, index) {
          return AppCategoryWidget(AppCategory(
            title: appState.role.appCategories[index].title,
            apps: appState.role.appCategories[index].apps,
          ));
        },
      );
    }

    // This shouldn't ever be reached
    return Center(
      child: Text("No app categories found"),
    );
  }
}
