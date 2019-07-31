import 'package:flutter/foundation.dart';

/// A class for holding app-wide state

class AppState extends ChangeNotifier {
  UserType _userType;

  UserType get userType => _userType;

  set userType(UserType userType) {
    _userType = userType;
    notifyListeners();
  }
}

enum UserType { NETID, COMMUNITY_ID }
