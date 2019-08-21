import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/models/app_category.dart';
import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/widgets/app_category_widget.dart';

/// The Links tab in My Apps
///
/// TODO: Move all search bar-related logic out of HomeRoute. It should really
///  be moved to either here or a third file. Does Flutter have anything like
///  Android's [setHasOptionsMenu](https://tinyurl.com/hasOptionsMenu)?
///
/// TODO: The first time the app runs, things can’t be favorited/un-favorited
///
/// TODO: The app currently remembers state for My Apps, but not for the other pages
class MyAppsLinks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    if (appState.role.linkCategories.isNotEmpty) {
      return ListView.builder(
        itemCount: appState.role.linkCategories.length,
        itemBuilder: (context, index) {
          return AppCategoryWidget(AppCategory(
            title: appState.role.linkCategories[index].title,
            apps: appState.role.linkCategories[index].apps,
          ));
        },
      );
    }

    return Center(
      child: Text("No results found"),
    );
  }
}
