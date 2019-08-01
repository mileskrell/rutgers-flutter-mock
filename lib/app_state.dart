import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class for holding app-wide state

class AppState extends ChangeNotifier {
  UserType _userType;

  UserType get userType => _userType;

  set userType(UserType userType) {
    _userType = userType;
    notifyListeners();
    () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("user_type", userTypeToString(userType));
    }();
  }
}

enum UserType {
  CURRENT_STUDENT,
  FACULTY,
  STAFF,
  ADMITTED_STUDENT,
  PARENT,
  ALUMNUS,
  GUEST
}

String userTypeToString(UserType userType) {
  if (userType == null) {
    return null;
  }
  switch (userType) {
    case UserType.CURRENT_STUDENT:
      return "current_student";
    case UserType.FACULTY:
      return "faculty";
    case UserType.STAFF:
      return "staff";
    case UserType.ADMITTED_STUDENT:
      return "admitted_student";
    case UserType.PARENT:
      return "parent";
    case UserType.ALUMNUS:
      return "alumnus";
    case UserType.GUEST:
      return "guest";
    default:
      throw "Unknown user type $userType";
  }
}

UserType stringToUserType(String userType) {
  switch (userType) {
    case "current_student":
      return UserType.CURRENT_STUDENT;
    case "faculty":
      return UserType.FACULTY;
    case "staff":
      return UserType.STAFF;
    case "admitted_student":
      return UserType.ADMITTED_STUDENT;
    case "parent":
      return UserType.PARENT;
    case "alumnus":
      return UserType.ALUMNUS;
    case "guest":
      return UserType.GUEST;
    default:
      throw "Unknown user type $userType";
  }
}
