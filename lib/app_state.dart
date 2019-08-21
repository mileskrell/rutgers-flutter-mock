import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rutgers_flutter_mock/home_pages/page_my_apps/app_catalog.dart';
import 'package:rutgers_flutter_mock/models/app.dart';
import 'package:rutgers_flutter_mock/models/home_page.dart';
import 'package:rutgers_flutter_mock/models/role.dart';
import 'package:rutgers_flutter_mock/resources.dart';

/// A class for holding app-wide state
class AppState extends ChangeNotifier {
  Role _role;

  Role get role => _role;

  set role(Role role) {
    _role = role;

    () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(keyRole, role?.title);
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
          keyFavoriteApps, favoriteApps.map((app) => app.sharedPrefsTag).toList());
    }();
  }

  /// Used by [SharedPrefsCheckRoute] to load favorites from [SharedPreferences]
  void loadFavoriteAppsFromTags(List<String> favoriteAppsTags) {
    favoriteApps = favoriteAppsTags
        // Make sure the current apps still contain the favorite apps
        .where((sharedPrefsTag) => allApps.containsKey(sharedPrefsTag))
        .map((sharedPrefsTag) => allApps[sharedPrefsTag])
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
      homePage = HomePage.MY_DAY;
      return;
    }

    if (role.hasMyDashboard) {
      homePage = HomePage.MY_DASHBOARD;
      return;
    }

    homePage = HomePage.MY_APPS;
  }
}
