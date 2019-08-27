import 'package:meta/meta.dart';

import 'package:rutgers_flutter_mock/home_pages/my_apps/default_favorite_apps.dart';
import 'package:rutgers_flutter_mock/home_pages/my_apps/link_catalog.dart';
import 'package:rutgers_flutter_mock/home_pages/my_apps/module_catalog.dart';
import 'package:rutgers_flutter_mock/models/app.dart';
import 'package:rutgers_flutter_mock/models/app_category.dart';
import 'package:rutgers_flutter_mock/resources.dart';

/// A category of user, as shown on the role selection route
class Role {
  static const CURRENT_STUDENT = Role(
    singular: "current student",
    plural: "current students",
    hasMyDay: true,
    hasMyDashboard: true,
    hasNetID: true,
    hasCommunityID: false,
    defaultFavoriteApps: currentStudentDefaultFavoriteApps,
    appCategories: currentStudentAppCategories,
    modules: currentStudentModules,
  );
  static const FACULTY = Role(
    singular: "faculty",
    plural: "faculty",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: true,
    hasCommunityID: false,
    defaultFavoriteApps: facultyDefaultFavoriteApps,
    appCategories: facultyAppCategories,
    modules: facultyModules,
  );
  static const STAFF = Role(
    singular: "staff",
    plural: "staff",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: true,
    hasCommunityID: false,
    defaultFavoriteApps: staffDefaultFavoriteApps,
    appCategories: staffAppCategories,
    modules: staffModules,
  );
  static const ADMITTED_STUDENT = Role(
    singular: "admitted student",
    plural: "admitted students",
    hasMyDay: false,
    hasMyDashboard: true,
    hasNetID: false,
    hasCommunityID: true,
    defaultFavoriteApps: admittedStudentDefaultFavoriteApps,
    appCategories: admittedStudentAppCategories,
    modules: admittedStudentModules,
  );
  static const PARENT = Role(
    singular: "parent",
    plural: "parents",
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
    singular: "alumnus",
    plural: "alumni",
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
    singular: "guest",
    plural: "guests",
    hasMyDay: false,
    hasMyDashboard: false,
    hasNetID: false,
    hasCommunityID: false,
    defaultFavoriteApps: guestDefaultFavoriteApps,
    appCategories: guestAppCategories,
    modules: guestModules,
  );

  final String singular;
  final String plural;
  final bool hasMyDay;
  final bool hasMyDashboard;
  final bool hasNetID;
  final bool hasCommunityID;
  final List<App> defaultFavoriteApps;
  final List<AppCategory> appCategories;
  final List<App> modules;

  const Role({
    @required this.singular,
    @required this.plural,
    @required this.hasMyDay,
    @required this.hasMyDashboard,
    @required this.hasNetID,
    @required this.hasCommunityID,
    @required this.defaultFavoriteApps,
    @required this.appCategories,
    @required this.modules,
  });

  factory Role.fromSingular(String singular) {
    if (singular == CURRENT_STUDENT.singular) return CURRENT_STUDENT;
    if (singular == FACULTY.singular) return FACULTY;
    if (singular == STAFF.singular) return STAFF;
    if (singular == ADMITTED_STUDENT.singular) return ADMITTED_STUDENT;
    if (singular == PARENT.singular) return PARENT;
    if (singular == ALUMNUS.singular) return ALUMNUS;
    if (singular == GUEST.singular) return GUEST;
    throw "Cannot create Role instance from unknown singular $singular";
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
