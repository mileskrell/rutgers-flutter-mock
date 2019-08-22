import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/home_pages/page_my_apps/link_catalog.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_apps/module_catalog.dart';
import 'package:rutgers_flutter_mock/widgets/app_widget.dart';

/// The search page in My Apps
class MyAppsSearch extends StatelessWidget {
  final String searchText;

  MyAppsSearch(this.searchText);

  @override
  Widget build(BuildContext context) {
    final filteredApps = [...allModules.values, ...allLinks.values]
        .where(
            (app) => app.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    if (filteredApps.isNotEmpty) {
      return ListView.builder(
        itemCount: filteredApps.length,
        itemBuilder: (context, index) {
          return AppWidget(filteredApps[index]);
        },
      );
    }

    return Center(
      child: Text("No matching links or modules found"),
    );
  }
}
