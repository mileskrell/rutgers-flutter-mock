import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_webview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_state.dart';
import '../resources.dart';

class MyDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (appState.userType == UserType.NETID) {
      return Center(
        child: Text("My Day page for NetID user"),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Log in with NetID to view My Day",
              style: bigTextStyle,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            RaisedButton(
              child: Text("Log in with NetID", style: bigTextStyle),
              onPressed: () async {
                await Navigator.push<bool>(context,
                    MaterialPageRoute(builder: (context) {
                  return WebViewRoute(
                      "https://cas.rutgers.edu/login?renew=true&service=https://my.rutgers.edu/portal/Login",
                      "Log in with NetID");
                }));

                appState.userType = UserType.NETID;

                unawaited(Navigator.pushReplacementNamed(context, "/home"));
                unawaited(() async {
                  final prefs = await SharedPreferences.getInstance();
                  unawaited(prefs.setString("user_type", "net"));
                  unawaited(prefs.setBool("has_completed_tutorial", true));
                }());
              },
            ),
          ],
        ),
      ),
    );
  }
}
