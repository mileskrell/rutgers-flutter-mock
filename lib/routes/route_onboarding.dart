import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_state.dart';
import '../resources.dart' show bigTextStyle, pantone186;
import 'route_webview.dart';

class OnboardingRoute extends StatefulWidget {
  AppState appState;

  OnboardingRoute(this.appState);

  @override
  State<StatefulWidget> createState() => OnboardingState();
}

class OnboardingState extends State<OnboardingRoute> {
  var currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Onboarding page"),
      ),
      body: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (newPageIndex) => setState(() {
              currentPageIndex = newPageIndex;
            }),
            children: <Widget>[
              Center(
                  child: Text(
                "Onboarding content",
                style: bigTextStyle,
              )),
              Center(
                  child: Text("More onboarding content", style: bigTextStyle)),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Log in with NetID", style: bigTextStyle),
                    onPressed: () async {
                      var loggedIn = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WebViewRoute(
                            "https://cas.rutgers.edu/login?renew=true&service=https://my.rutgers.edu/portal/Login",
                        "Log in with NetID");
                      }));

                      widget.appState.userType = UserType.NETID;

                      Navigator.pushReplacementNamed(context, "/home");
                      () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString("user_type", "net");
                        prefs.setBool("has_completed_tutorial", true);
                      }();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                  ),
                  RaisedButton(
                    child:
                        Text("Log in with Community ID", style: bigTextStyle),
                    onPressed: () async {
                      var loggedIn = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WebViewRoute(
                            "https://cas.rutgers.edu/login?renew=true&service=https://my.rutgers.edu/portal/Login",
                        "Log in with Community ID");
                      }));

                      widget.appState.userType = UserType.COMMUNITY_ID;

                      Navigator.pushReplacementNamed(context, "/home");
                      () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString("user_type", "community");
                        prefs.setBool("has_completed_tutorial", true);
                      }();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                  ),
                  RaisedButton(
                    child: Text("Enter without logging in"),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/home");
                      () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString("user_type", null);
                        prefs.setBool("has_completed_tutorial", true);
                      }();
                    },
                  )
                ],
              ))
            ],
          ),
          Align(
            alignment: Alignment(0, 0.75),
            child: DotsIndicator(
              dotsCount: 3,
              position: currentPageIndex,
              decorator: DotsDecorator(activeColor: pantone186),
            ),
          )
        ],
      ),
    );
  }
}
