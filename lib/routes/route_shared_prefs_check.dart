import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/resources.dart';

/// This route is launched on app startup. It uses [SharedPreferences] to check
/// whether the user has completed the tutorial. If not, it launches
/// OnboardingRoute.
///
/// If the tutorial has already been completed, it launches either LoginRoute
/// (if the user is not logged in) or HomeRoute (if the user is logged in).
class SharedPrefsCheckRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    () async {
      final prefs = await SharedPreferences.getInstance();

      final hasSeenTutorial = prefs.getBool(keyHasCompletedTutorial) ?? false;
      if (hasSeenTutorial) {
        final savedRole = prefs.getString(keyRole);
        if (savedRole == null) {
          Navigator.pushReplacementNamed(context, "/login");
        } else {
          appState.role = stringToRole(savedRole);
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
