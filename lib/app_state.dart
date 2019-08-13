import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
