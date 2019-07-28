import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingCheckRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OnboardingCheckState();
}

class OnboardingCheckState extends State<OnboardingCheckRoute> {
  OnboardingCheckState() {
    () async {
      final prefs = await SharedPreferences.getInstance();
      var hasSeenTutorial = prefs.getBool("has_completed_tutorial") ?? false;
      if (hasSeenTutorial) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/onboarding");
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
