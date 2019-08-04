import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rutgers_flutter_mock/app_state.dart';

/// This route is launched on app startup. It uses [SharedPreferences] to check
/// whether the user has completed the tutorial. If not, it launches
/// OnboardingRoute.
///
/// If the tutorial has already been completed, it launches either LoginRoute
/// (if the user is not logged in) or HomeRoute (if the user is logged in).
class OnboardingCheckRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    () async {
      final prefs = await SharedPreferences.getInstance();

      final hasSeenTutorial = prefs.getBool("has_completed_tutorial") ?? false;
      if (hasSeenTutorial) {
        final savedUserTypeString = prefs.getString("user_type");
        if (savedUserTypeString == null) {
          Navigator.pushReplacementNamed(context, "/login");
        } else {
          appState.userType = stringToUserType(savedUserTypeString);
          Navigator.pushReplacementNamed(context, "/home");
        }
      } else {
        Navigator.pushReplacementNamed(context, "/onboarding");
      }
    }();

    return Scaffold(
      appBar: AppBar(
        title: Text("Rutgers"),
      ),
      body: Center(child: Text("Loading...")),
    );
  }
}
