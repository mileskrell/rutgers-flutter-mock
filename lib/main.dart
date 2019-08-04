import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_basic_flutter_mock/app_state.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_bus/page_bus.dart';
import 'package:rutgers_basic_flutter_mock/resources.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_home.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_login.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_onboarding.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_onboarding_check.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      builder: (context) => AppState(),
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primaryColor: pantone186,
          accentColor: pantone186, // TODO Maybe change this?
          cursorColor: Colors.white,
          textSelectionColor: pantone431,
          textSelectionHandleColor: pantone431,
        ),
        routes: {
          "/": (context) => OnboardingCheckRoute(),
          "/onboarding": (context) => OnboardingRoute(),

          // To open the login page shown within the tutorial,
          // push LoginRoute(onboardingMode: true)
          "/login": (context) => LoginRoute(),
          "/home": (context) => HomeRoute(),
          "/bus": (context) => Bus()
        },
        initialRoute: "/",
      ),
    );
  }
}
