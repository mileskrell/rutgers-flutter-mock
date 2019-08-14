import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rutgers_flutter_mock/home_pages/page_bus/page_bus.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_apps/app_catalog.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_apps/page_my_apps.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_dashboard.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_day.dart';
import 'package:rutgers_flutter_mock/models/app.dart';
import 'package:rutgers_flutter_mock/resources.dart';

/// A class for holding app-wide state
class AppState extends ChangeNotifier {
  Role _role;

  Role get role => _role;

  set role(Role role) {
    _role = role;

    () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(keyRole, roleToString(role));
    }();

    // If the role has been set to null, it means the user has just logged out.
    // Notifying listeners would tell e.g. HomePage to rebuild with a null
    // role, which would display errors. So instead, we'll have to just assume
    // that any widgets depending on the role will be closed promptly.

    // Tl;dr, it's assumed that setting the role to null means you're about
    // to return to the role selection page and would prefer for the currently
    // -displayed pages not to be updated.
    if (role != null) {
      notifyListeners();
    }
  }

  bool _loggedIn;

  bool get loggedIn => _loggedIn;

  set loggedIn(bool loggedIn) {
    _loggedIn = loggedIn;
    notifyListeners();
    () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(keyLoggedIn, loggedIn);
    }();
  }

  bool _hasCompletedTutorial;

  bool get hasCompletedTutorial => _hasCompletedTutorial;

  set hasCompletedTutorial(bool hasCompletedTutorial) {
    _hasCompletedTutorial = hasCompletedTutorial;
    notifyListeners();
    () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(keyHasCompletedTutorial, hasCompletedTutorial);
    }();
  }

  List<App> _favoriteApps;

  List<App> get favoriteApps => _favoriteApps;

  set favoriteApps(List<App> favoriteApps) {
    _favoriteApps = favoriteApps;
    notifyListeners();
    () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList(
          keyFavoriteApps, favoriteApps.map((app) => app.tag).toList());
    }();
  }

  /// Used by [SharedPrefsCheckRoute] to load favorites from [SharedPreferences]
  void loadFavoriteAppsFromTags(List<String> favoriteAppsTags) {
    favoriteApps = favoriteAppsTags
        // Make sure the current apps still contain the favorite apps
        .where((tag) => allApps.containsKey(tag))
        .map((tag) => allApps[tag])
        .toList();
  }

  HomePage _homePage;

  HomePage get homePage => _homePage;

  set homePage(HomePage homePage) {
    _homePage = homePage;
    notifyListeners();
    () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(keyHomePage, homePage.title);
    }();
  }

  /// Used by [SharedPrefsCheckRoute] to load favorites from [SharedPreferences].
  /// Note that the provided [title] can be null, in which case it's ignored.
  void setHomePageFromTitle(String title) {
    // If the page the user had selected as their home still exists, use it
    if (HomePage.pages.containsKey(title)) {
      homePage = HomePage.pages[title];
      return;
    }

    // Otherwise, try one of the other pages

    if (roleHasMyDay(role)) {
      homePage = MY_DAY;
      return;
    }

    if (roleHasMyDashboard(role)) {
      homePage = MY_DASHBOARD;
      return;
    }

    homePage = MY_APPS;
  }
}

enum Role {
  CURRENT_STUDENT,
  FACULTY,
  STAFF,
  ADMITTED_STUDENT,
  PARENT,
  ALUMNUS,
  GUEST
}

/// In many languages, enums can contain fields and methods.
/// But not in Dart, so we have this extra method here.
String roleToString(Role role) {
  if (role == null) {
    return null;
  }
  switch (role) {
    case Role.CURRENT_STUDENT:
      return "current_student";
    case Role.FACULTY:
      return "faculty";
    case Role.STAFF:
      return "staff";
    case Role.ADMITTED_STUDENT:
      return "admitted_student";
    case Role.PARENT:
      return "parent";
    case Role.ALUMNUS:
      return "alumnus";
    case Role.GUEST:
      return "guest";
    default:
      throw "Unknown role $role";
  }
}

Role stringToRole(String role) {
  switch (role) {
    case "current_student":
      return Role.CURRENT_STUDENT;
    case "faculty":
      return Role.FACULTY;
    case "staff":
      return Role.STAFF;
    case "admitted_student":
      return Role.ADMITTED_STUDENT;
    case "parent":
      return Role.PARENT;
    case "alumnus":
      return Role.ALUMNUS;
    case "guest":
      return Role.GUEST;
    default:
      throw "Unknown role $role";
  }
}

bool roleHasMyDay(Role role) {
  return role == Role.CURRENT_STUDENT;
}

bool roleHasMyDashboard(Role role) {
  return role == Role.CURRENT_STUDENT ||
      role == Role.FACULTY ||
      role == Role.STAFF ||
      role == Role.ADMITTED_STUDENT ||
      role == Role.PARENT;
}

bool roleHasNetID(Role role) {
  return role == Role.CURRENT_STUDENT ||
      role == Role.FACULTY ||
      role == Role.STAFF;
}

bool roleHasCommunityID(Role role) {
  return role == Role.ADMITTED_STUDENT || role == Role.PARENT;
}

const MY_DAY = HomePage(
  title: "My Day",
  associatedPage: MyDay,
);
const HomePage MY_DASHBOARD = HomePage(
  title: "My Dashboard",
  associatedPage: MyDashboard,
);
const HomePage MY_APPS = HomePage(
  title: "My Apps",
  associatedPage: MyApps,
);
const HomePage BUS = HomePage(
  title: "Bus",
  associatedPage: Bus,
);

class HomePage {
  final String title;

  final Type associatedPage;

  const HomePage({this.title, this.associatedPage});

  static final pages = Map<String, HomePage>.fromIterable(
    <HomePage>[
      MY_DAY,
      MY_DASHBOARD,
      MY_APPS,
      BUS,
    ],
    key: (dynamic element) => (element as HomePage).title,
  );
}
