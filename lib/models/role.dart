import 'package:meta/meta.dart';

import 'package:rutgers_flutter_mock/home_pages/page_my_apps/default_favorite_apps.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_apps/link_catalog.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_apps/module_catalog.dart';
import 'package:rutgers_flutter_mock/models/app.dart';
import 'package:rutgers_flutter_mock/models/app_category.dart';
import 'package:rutgers_flutter_mock/resources.dart';

/// A category of user, as shown on the role selection route
class Role {
  static const CURRENT_STUDENT = Role(
    title: "current student",
    hasMyDay: true,
    hasMyDashboard: true,
    hasNetID: true,
    hasCommunityID: false,
    defaultFavoriteApps: currentStudentDefaultFavoriteApps,
    appCategories: currentStudentAppCategories,
    modules: currentStudentModules,
  );
  static const FACULTY = Role(
    title: "faculty",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: true,
    hasCommunityID: false,
    defaultFavoriteApps: facultyDefaultFavoriteApps,
    appCategories: facultyAppCategories,
    modules: facultyModules,
  );
  static const STAFF = Role(
    title: "staff",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: true,
    hasCommunityID: false,
    defaultFavoriteApps: staffDefaultFavoriteApps,
    appCategories: staffAppCategories,
    modules: staffModules,
  );
  static const ADMITTED_STUDENT = Role(
    title: "admitted student",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: false,
    hasCommunityID: true,
    defaultFavoriteApps: admittedStudentDefaultFavoriteApps,
    appCategories: admittedStudentAppCategories,
    modules: admittedStudentModules,
  );
  static const PARENT = Role(
    title: "parent",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: false,
    hasCommunityID: true,
    defaultFavoriteApps: parentDefaultFavoriteApps,
    appCategories: parentAppCategories,
    modules: parentModules,
  );
  static const ALUMNUS = Role(
    // Never seen in mockup
    title: "alumnus",
    hasMyDay: false,
    hasMyDashboard: false,
    hasNetID: false,
    // TODO Check this
    hasCommunityID: false,
    defaultFavoriteApps: alumnusDefaultFavoriteApps,
    appCategories: alumnusAppCategories,
    modules: alumnusModules,
  );
  static const GUEST = Role(
    title: "guest",
    hasMyDay: false,
    hasMyDashboard: false,
    hasNetID: false,
    hasCommunityID: false,
    defaultFavoriteApps: guestDefaultFavoriteApps,
    appCategories: guestAppCategories,
    modules: guestModules,
  );

  final String title;
  final bool hasMyDay;
  final bool hasMyDashboard;
  final bool hasNetID;
  final bool hasCommunityID;
  final List<App> defaultFavoriteApps;
  final List<AppCategory> appCategories;
  final List<App> modules;

  const Role({
    @required this.title,
    @required this.hasMyDay,
    @required this.hasMyDashboard,
    @required this.hasNetID,
    @required this.hasCommunityID,
    @required this.defaultFavoriteApps,
    @required this.appCategories,
    @required this.modules,
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

  String get loginUrl {
    if (hasNetID) {
      return netIdUrl;
    }
    return communityIdUrl;
  }

  List<Object> get loginExplanation {
    if (hasNetID) {
      return netIDExplanation;
    }
    return communityIDExplanation;
  }
}
