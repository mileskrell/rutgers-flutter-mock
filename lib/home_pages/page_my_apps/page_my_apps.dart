import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/home_pages/page_my_apps/app_catalog.dart';
import 'package:rutgers_flutter_mock/models/app.dart';
import 'package:rutgers_flutter_mock/widgets/app_widget.dart';

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
    List<App> filteredApps;

    if (searchText.isEmpty) {
      filteredApps = allApps.values.toList();
    } else {
      filteredApps = allApps.values
          .where((app) =>
              app.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    if (filteredApps.isNotEmpty) {
      return ListView.builder(
        itemCount: filteredApps.length,
        itemBuilder: (context, index) {
          return AppWidget(
            filteredApps[index],
            style: AppWidgetStyle.CARD,
          );
        },
      );
    }

    return Center(
      child: Text("No results found"),
    );
  }
}
