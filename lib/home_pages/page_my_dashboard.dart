import 'package:flutter/material.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_webview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_state.dart';
import '../resources.dart';

class MyDashboard extends StatefulWidget {
  AppState appState;

  MyDashboard(this.appState);

  @override
  State<StatefulWidget> createState() => MyDashboardState();
}

class MyDashboardState extends State<MyDashboard> {
  @override
  Widget build(BuildContext context) {
    if (widget.appState.userType == UserType.NETID) {
      return Center(
        child: Text("My Dashboard page for NetID user"),
      );
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Log in with NetID to view My Dashboard",
            style: bigTextStyle,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          RaisedButton(
            child: Text("Log in with NetID", style: bigTextStyle),
            onPressed: () async {
              var loggedIn = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return WebViewRoute(
                    "https://cas.rutgers.edu/login?renew=true&service=https://my.rutgers.edu/portal/Login",
                    "Log in with NetID");
              }));

              setState(() {
                widget.appState.userType = UserType.NETID;
              });

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
        ],
      ),
    );
  }
}
