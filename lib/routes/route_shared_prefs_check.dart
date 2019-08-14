import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/resources.dart';

/// This route is launched on app startup. It uses [SharedPreferences] to check
/// whether the user has both selected their role and completed the tutorial.
///
/// If they have, it launches HomeRoute.
///
/// Otherwise, it launches RoleSelectionRoute.
class SharedPrefsCheckRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    () async {
      final prefs = await SharedPreferences.getInstance();
      final savedRole = prefs.getString(keyRole);
      final hasCompletedTutorial =
          prefs.getBool(keyHasCompletedTutorial) ?? false;

      if (savedRole != null && hasCompletedTutorial) {
        appState.role = stringToRole(savedRole);
        appState.hasCompletedTutorial = true;
        appState.loggedIn = prefs.getBool(keyLoggedIn);
        appState.loadFavoriteAppsFromTags(
            prefs.getStringList(keyFavoriteApps) ?? []);
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/roleSelection");
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
