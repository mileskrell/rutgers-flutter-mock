import 'package:flutter/material.dart';

import 'resources.dart';
import 'route_home.dart' show HomeRoute;
import 'route_onboarding.dart' show OnboardingRoute;
import 'route_onboarding_check.dart' show OnboardingCheckRoute;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
          primaryColor: pantone186,
          accentColor: pantone186 // TODO Maybe change this?
          ),
      routes: {
        "/": (context) => OnboardingCheckRoute(),
        "/onboarding": (context) => OnboardingRoute(),
        "/home": (context) => HomeRoute()
      },
      initialRoute: "/",
    );
  }
}
