import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_apps/app_catalog.dart';
import 'package:rutgers_flutter_mock/widgets/my_apps_app_widget.dart';

/// The My Apps page. Currently shows different [App]s to each type of user.
///
/// While on this page, a search button is included in the app bar. This filters
/// the list of apps shown as the user types.
///
/// TODO: Display favorites and other apps separately.
///
/// TODO: Probably all or almost all apps should be visible to everyone.
///  Different types of users should just have different *favorites* by default,
///  that's all.
///
/// TODO: Move all search bar-related logic out of HomeRoute. It should really
///  be moved to either here or a third file. Does Flutter have anything like
///  Android's [setHasOptionsMenu](https://tinyurl.com/hasOptionsMenu)?
class MyApps extends StatelessWidget {
  final String searchText;

  MyApps(this.searchText);

  @override
  Widget build(BuildContext context) {
    final userType = Provider.of<AppState>(context).userType;
    List<App> favorites;

    switch (userType) {
      case UserType.CURRENT_STUDENT:
        favorites = currentStudentFavorites;
        break;

      case UserType.FACULTY:
        favorites = facultyFavorites;
        break;

      case UserType.STAFF:
        favorites = staffFavorites;
        break;

      case UserType.ADMITTED_STUDENT:
        favorites = admittedStudentFavorites;
        break;

      case UserType.PARENT:
        favorites = parentFavorites;
        break;

      case UserType.ALUMNUS:
        favorites = alumnusFavorites;
        break;

      // Guest
      case UserType.GUEST:
        favorites = guestFavorites;
        break;

      default:
        throw "Unknown user type $userType";
    }

    if (searchText.isNotEmpty) {
      favorites = favorites
          .where((app) =>
              app.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    List<App> others = allApps.where((it) => !favorites.contains(it)).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Column(
//          initiallyExpanded: true,
//          title: Text("Favorites"),
          children: <Widget>[
            Expanded(
              child: ListView.builder(
//                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) => favorites[index]),
            )
          ],
        ),

      ],
    );
  }
}
