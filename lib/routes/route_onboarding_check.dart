import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_state.dart';

class OnboardingCheckRoute extends StatefulWidget {
  final AppState appState;

  OnboardingCheckRoute(this.appState);

  @override
  State<StatefulWidget> createState() => OnboardingCheckState();
}

class OnboardingCheckState extends State<OnboardingCheckRoute> {
  OnboardingCheckState() {
    () async {
      final prefs = await SharedPreferences.getInstance();

      widget.appState.userType = {
        "net": UserType.NETID,
        "community": UserType.COMMUNITY_ID,
        null: null
      }[prefs.getString("user_type")];

      final hasSeenTutorial = prefs.getBool("has_completed_tutorial") ?? false;
      if (hasSeenTutorial) {
        unawaited(Navigator.pushReplacementNamed(context, "/home"));
      } else {
        unawaited(Navigator.pushReplacementNamed(context, "/onboarding"));
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rutgers"),
      ),
      body: Center(child: Text("Loading...")),
    );
  }
}
