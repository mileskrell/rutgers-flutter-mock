import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/models/role.dart';
import 'package:rutgers_flutter_mock/resources.dart';
import 'package:rutgers_flutter_mock/routes/route_webview.dart';
import 'package:rutgers_flutter_mock/widgets/link_text.dart';
import 'package:rutgers_flutter_mock/widgets/gradient_button.dart';

/// This is the last page of the tutorial. Depending on the user's role, it
/// might prompt them to log in.
///
/// The app allows users to view the tutorial multiple times. If the user has
/// seen the tutorial before, the login prompt will not be presented.
class OnboardingLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    // If user has already seen tutorial
    if (appState.hasCompletedTutorial) {
      return Scaffold(
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Return to the Rutgers app"),
          ),
        ),
      );
    }

    // If user is a guest
    if (appState.role == Role.GUEST) {
      return Scaffold(
        body: Center(
          child: GradientButton(
            title: "Enter the Rutgers app",
            isBigSquare: true,
            onPressed: () {
              appState.loggedIn = false;
              launchHome(context, appState);
            },
          ),
        ),
      );
    }

    // Everyone else (non-guests who haven't seen the tutorial before)
    final loginMethod = appState.role.hasNetID ? netID : communityID;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Would you like to personalize your experience with us?",
              style: bigTextStyle,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            GradientButton(
              title: "Log in with $loginMethod",
              isBigSquare: true,
              size: 160, // wide enough to say "CommunityID"
              onPressed: () async {
                await Navigator.push<bool>(context,
                    MaterialPageRoute(builder: (context) {
                  return WebViewRoute(
                      appState.role.loginUrl, "Log in with $loginMethod");
                }));
                appState.loggedIn = true;
                launchHome(context, appState);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
            ),
            GradientButton(
              title: "What's a $loginMethod?",
              isBigSquare: false,
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("What's a $loginMethod?"),
                      content:
                          LinkText(children: appState.role.loginExplanation),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Close"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Text("Skip"),
              color: Colors.white,
              highlightColor: Colors.white,
              onPressed: () {
                appState.loggedIn = false;
                launchHome(context, appState);
              },
            ),
          ],
        ),
      ),
    );
  }

  void launchHome(BuildContext context, AppState appState) {
    appState.hasCompletedTutorial = true;
    Navigator.pop(context); // Pop, returning to role selection route
    Navigator.pushReplacementNamed(context, "/home"); // Replace with home route
  }
}
