import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/home_pages/bus/bus.dart';
import 'package:rutgers_flutter_mock/resources.dart';
import 'package:rutgers_flutter_mock/routes/route_home.dart';
import 'package:rutgers_flutter_mock/routes/route_onboarding.dart';
import 'package:rutgers_flutter_mock/routes/route_role_selection.dart';
import 'package:rutgers_flutter_mock/routes/route_settings.dart';
import 'package:rutgers_flutter_mock/routes/route_shared_prefs_check.dart';

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
          "/": (context) => SharedPrefsCheckRoute(),
          "/roleSelection": (context) => RoleSelectionRoute(),
          "/onboarding": (context) => OnboardingRoute(),
          "/home": (context) => HomeRoute(),
          "/bus": (context) => Bus(),
          "/settings": (context) => SettingsRoute(),
        },
        initialRoute: "/",
      ),
    );
  }
}
