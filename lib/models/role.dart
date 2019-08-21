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
    linkCategories: currentStudentLinkCategories,
    modules: currentStudentModules,
  );
  static const FACULTY = Role(
    title: "faculty",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: true,
    hasCommunityID: false,
    defaultFavoriteApps: facultyDefaultFavoriteApps,
    linkCategories: facultyLinkCategories,
    modules: facultyModules,
  );
  static const STAFF = Role(
    title: "staff",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: true,
    hasCommunityID: false,
    defaultFavoriteApps: staffDefaultFavoriteApps,
    linkCategories: staffLinkCategories,
    modules: staffModules,
  );
  static const ADMITTED_STUDENT = Role(
    title: "admitted student",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: false,
    hasCommunityID: true,
    defaultFavoriteApps: admittedStudentDefaultFavoriteApps,
    linkCategories: admittedStudentLinkCategories,
    modules: admittedStudentModules,
  );
  static const PARENT = Role(
    title: "parent",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: false,
    hasCommunityID: true,
    defaultFavoriteApps: parentDefaultFavoriteApps,
    linkCategories: parentLinkCategories,
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
    linkCategories: alumnusLinkCategories,
    modules: alumnusModules,
  );
  static const GUEST = Role(
    title: "guest",
    hasMyDay: false,
    hasMyDashboard: false,
    hasNetID: false,
    hasCommunityID: false,
    defaultFavoriteApps: guestDefaultFavoriteApps,
    linkCategories: guestLinkCategories,
    modules: guestModules,
  );

  final String title;
  final bool hasMyDay;
  final bool hasMyDashboard;
  final bool hasNetID;
  final bool hasCommunityID;
  final List<App> defaultFavoriteApps;
  final List<AppCategory> linkCategories;
  final List<App> modules;

  const Role({
    @required this.title,
    @required this.hasMyDay,
    @required this.hasMyDashboard,
    @required this.hasNetID,
    @required this.hasCommunityID,
    @required this.defaultFavoriteApps,
    @required this.linkCategories,
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
