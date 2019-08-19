import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/models/app_category.dart';
import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/widgets/app_category_widget.dart';

/// The My Apps page.
///
/// While on this page, a search button is included in the app bar. This filters
/// the list of apps shown as the user types.
///
/// TODO: Move all search bar-related logic out of HomeRoute. It should really
///  be moved to either here or a third file. Does Flutter have anything like
///  Android's [setHasOptionsMenu](https://tinyurl.com/hasOptionsMenu)?
class MyApps extends StatelessWidget {
  final String searchText;

  MyApps(this.searchText);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    List<AppCategory> appCategories = appState.role.appCategories;

    if (searchText.isNotEmpty) {
      appCategories = appCategories
          // Only show apps matching search text in each category
          .map((category) {
            final filteredApps = category.apps
                .where((app) =>
                    app.title.toLowerCase().contains(searchText.toLowerCase()))
                .toList();
            return AppCategory(title: category.title, apps: filteredApps);
          })
          // Filter out any categories that are now empty
          .where((category) => category.apps.isNotEmpty)
          .toList();
    }

    if (appCategories.isNotEmpty) {
      return ListView.builder(
        itemCount: appCategories.length,
        itemBuilder: (context, index) {
          return AppCategoryWidget(AppCategory(
            title: appCategories[index].title,
            apps: appCategories[index].apps,
          ));
        },
      );
    }

    return Center(
      child: Text("No results found"),
    );
  }
}
