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
      prefs.setString(keyRole, role.title);
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

    if (role.hasMyDay) {
      homePage = MY_DAY;
      return;
    }

    if (role.hasMyDashboard) {
      homePage = MY_DASHBOARD;
      return;
    }

    homePage = MY_APPS;
  }
}

class Role {
  static const CURRENT_STUDENT = Role(
    title: "current student",
    hasMyDay: true,
    hasMyDashboard: true,
    hasNetID: true,
    hasCommunityID: false,
  );
  static const FACULTY = Role(
    title: "faculty",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: true,
    hasCommunityID: false,
  );
  static const STAFF = Role(
    title: "staff",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: true,
    hasCommunityID: false,
  );
  static const ADMITTED_STUDENT = Role(
    title: "admitted student",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: false,
    hasCommunityID: true,
  );
  static const PARENT = Role(
    title: "parent",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: false,
    hasCommunityID: true,
  );
  static const ALUMNUS = Role(
    title: "alumnus",
    hasMyDay: false,
    hasMyDashboard: false,
    hasNetID: false, // TODO Check this
    hasCommunityID: false,
  );
  static const GUEST = Role(
    title: "guest",
    hasMyDay: false,
    hasMyDashboard: false,
    hasNetID: false,
    hasCommunityID: false,
  );

  final String title;
  final bool hasMyDay;
  final bool hasMyDashboard;
  final bool hasNetID;
  final bool hasCommunityID;

  const Role({
    @required this.title,
    @required this.hasMyDay,
    @required this.hasMyDashboard,
    @required this.hasNetID,
    @required this.hasCommunityID,
  });

  factory Role.fromTitle(String title) {
    if (title == CURRENT_STUDENT.title) return CURRENT_STUDENT;
    if (title == FACULTY.title) return FACULTY;
    if (title == STAFF.title) return STAFF;
    if (title == ADMITTED_STUDENT.title) return ADMITTED_STUDENT;
    if (title == PARENT.title) return PARENT;
    if (title == ALUMNUS.title) return ALUMNUS;
    if (title == GUEST.title) return GUEST;
    throw "Cannot create Role instance from unknown title $title";
  }
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
