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
    List<App> filteredApps;

    switch (userType) {
      case UserType.CURRENT_STUDENT:
        filteredApps = currentStudentApps;
        break;

      case UserType.FACULTY:
        filteredApps = facultyApps;
        break;

      case UserType.STAFF:
        filteredApps = staffApps;
        break;

      case UserType.ADMITTED_STUDENT:
        filteredApps = admittedStudentApps;
        break;

      case UserType.PARENT:
        filteredApps = parentApps;
        break;

      case UserType.ALUMNUS:
        filteredApps = alumnusApps;
        break;

      // Guest
      case UserType.GUEST:
        filteredApps = guestApps;
        break;

      default:
        throw "Unknown user type $userType";
    }

    if (searchText.isNotEmpty) {
      filteredApps = filteredApps
          .where((app) =>
              app.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    return ListView.builder(
        itemCount: filteredApps.length,
        itemBuilder: (context, index) => filteredApps[index]);
  }
}
