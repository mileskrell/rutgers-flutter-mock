import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rutgers_basic_flutter_mock/app_state.dart';

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
