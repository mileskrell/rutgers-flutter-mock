import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
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
    String loginMethod, loginUrl;
    List<Object> loginMethodExplanation;

    if (appState.role == Role.ADMITTED_STUDENT ||
        appState.role == Role.PARENT) {
      loginMethod = "CommunityID";
      loginMethodExplanation = [
        "A CommunityID account is used to access applications by the "
            "extended community of Rutgers University."
            "\n\nIf you have not yet created a CommunityID, you can do so ",
        Link(
            text: "here",
            url: "https://rcm.rutgers.edu",
            linkTitle: "CommunityID"),
        "."
      ];

      loginUrl =
          "data:text/html,<!DOCTYPE html><p>This would be the CommunityID login page</p>";
    } else {
      // user is student, staff, or faculty
      loginMethod = "NetID";
      loginMethodExplanation = [
        "All faculty, staff, students and guests are assigned a "
            "Rutgers unique identifier known as a NetID, comprised of "
            "initials and a unique number (e.g. jqs23)."
            "\n\nIf you have not yet activated your NetID, you can do so ",
        Link(
            text: "here", url: "https://netid.rutgers.edu", linkTitle: "NetID"),
        "."
      ];

      loginUrl =
          "https://cas.rutgers.edu/login?renew=true&service=https://my.rutgers.edu/portal/Login";
    }

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
                  return WebViewRoute(loginUrl, "Log in with $loginMethod");
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
                        content: LinkText(children: loginMethodExplanation),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Close"),
                          ),
                        ],
                      );
                    });
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
