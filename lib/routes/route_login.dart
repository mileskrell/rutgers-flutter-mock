import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_basic_flutter_mock/app_state.dart';
import 'package:rutgers_basic_flutter_mock/resources.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_webview.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class can be used in two ways.
///
/// By default, it acts as a standalone route.
/// It's also used as the final page of the onboarding route.
class LoginRoute extends StatefulWidget {
  /// If true, only returns the body.
  /// By default, returns a [Scaffold].
  final bool onboardingMode;

  LoginRoute({this.onboardingMode = false});

  @override
  State<StatefulWidget> createState() => LoginRouteState();
}

class LoginRouteState extends State<LoginRoute> {
  bool alreadySetUserTypeToNull = false;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    // When this is launched as a standalone route, it means that the user has
    // just logged out.
    //
    // To ensure the user isn't logged out until they've actually moved to this
    // route, we actually handle the logout here.
    if (!widget.onboardingMode && !alreadySetUserTypeToNull) {
      alreadySetUserTypeToNull = true;
      () async {
        // Delay so we don't set state during build
        await Future<Null>.delayed(Duration(seconds: 1));
        // Make sure we only do this once
        appState.userType = null;
      }();
    }

    final body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (widget.onboardingMode)
            Text(
              "Choose an option\nbelow to get started",
              style: bigTextStyle,
              textAlign: TextAlign.center,
            ),
          if (widget.onboardingMode)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          RaisedButton(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Text("Log in with NetID", style: bigTextStyle),
                  Text("(for students, faculty, and staff)"),
                ],
              ),
            ),
            color: Colors.white,
            highlightColor: Colors.white,
            onPressed: () async {
              await Navigator.push<bool>(context,
                  MaterialPageRoute(builder: (context) {
                return WebViewRoute(
                    "https://cas.rutgers.edu/login?renew=true&service=https://my.rutgers.edu/portal/Login",
                    "Log in with NetID");
              }));
              logInAndSave(appState, context, UserType.CURRENT_STUDENT);
              launchHome(context);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          RaisedButton(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Text("Log in with Community ID", style: bigTextStyle),
                  Text("(for parents and admitted students)"),
                ],
              ),
            ),
            color: Colors.white,
            highlightColor: Colors.white,
            onPressed: () async {
              await Navigator.push<bool>(context,
                  MaterialPageRoute(builder: (context) {
                return WebViewRoute(
                    "https://cas.rutgers.edu/login?renew=true&service=https://my.rutgers.edu/portal/Login",
                    "Log in with Community ID");
              }));
              logInAndSave(appState, context, UserType.ADMITTED_STUDENT);
              launchHome(context);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          RaisedButton(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Text("Use without logging in", style: bigTextStyle),
                  Text("(for alumni and guests)"),
                ],
              ),
            ),
            color: Colors.white,
            highlightColor: Colors.white,
            onPressed: () async {
              final userType = await showDialog<UserType>(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text("I am a..."),
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, UserType.ALUMNUS);
                          },
                          child: Text("Alumnus"),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, UserType.GUEST);
                          },
                          child: Text("Guest"),
                        ),
                      ],
                    );
                  });
              if (userType != null) {
                logInAndSave(appState, context, userType);
                launchHome(context);
              }
            },
          ),
        ],
      ),
    );

    if (widget.onboardingMode) {
      return body;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Log in"),
        ),
        body: body,
      );
    }
  }

  void logInAndSave(
      AppState appState, BuildContext context, UserType userType) {
    appState.userType = userType;

    () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("has_completed_tutorial", true);
    }();
  }

  void launchHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }
}
