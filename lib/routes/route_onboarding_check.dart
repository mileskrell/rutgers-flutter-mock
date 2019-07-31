import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rutgers_basic_flutter_mock/app_state.dart';

class OnboardingCheckRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    () async {
      final prefs = await SharedPreferences.getInstance();

      appState.userType = {
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Rutgers"),
      ),
      body: Center(child: Text("Loading...")),
    );
  }
}
