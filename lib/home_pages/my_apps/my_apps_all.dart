import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/home_pages/my_apps/link_catalog.dart';
import 'package:rutgers_flutter_mock/models/app_category.dart';
import 'package:rutgers_flutter_mock/widgets/app_category_widget.dart';

/// The All tab in My Apps
///
/// TODO: Move all search bar-related logic out of HomeRoute. It should really
///  be moved to either here or a third file. Does Flutter have anything like
///  Android's [setHasOptionsMenu](https://tinyurl.com/hasOptionsMenu)?
///
/// TODO: The first time the app runs, things can’t be favorited/un-favorited
///
/// TODO: The app currently remembers state for My Apps, but not for the other pages
class MyAppsAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final allCategoriesList = allAppCategories.toList();

    if (allCategoriesList.isNotEmpty) {
      return ListView.builder(
        itemCount: allCategoriesList.length,
        itemBuilder: (context, index) {
          return AppCategoryWidget(AppCategory(
            title: allCategoriesList[index].title,
            apps: allCategoriesList[index].apps,
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
