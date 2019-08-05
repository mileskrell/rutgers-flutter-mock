import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rutgers_flutter_mock/resources.dart';

/// A class for holding app-wide state
class AppState extends ChangeNotifier {
  Role _role;

  Role get role => _role;

  // Whenever the role is set, we notify listeners and save it to disk
  set role(Role role) {
    _role = role;
    notifyListeners();
    () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(keyRole, roleToString(role));
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
