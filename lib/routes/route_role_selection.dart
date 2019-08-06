import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/resources.dart';
import 'package:rutgers_flutter_mock/widgets/square_gradient_button.dart';

class RoleSelectionRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    // TODO There's no option for alumni!

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Text(
              "Choose your role to continue",
              style: TextStyle(fontSize: 26),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SquareGradientButton(
                  title: "Student",
                  onPressed: () {
                    launchOnboarding(context, appState, Role.CURRENT_STUDENT);
                  },
                ),
                SquareGradientButton(
                  title: "Staff",
                  onPressed: () {
                    launchOnboarding(context, appState, Role.STAFF);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SquareGradientButton(
                  title: "Faculty",
                  onPressed: () {
                    launchOnboarding(context, appState, Role.FACULTY);
                  },
                ),
                SquareGradientButton(
                  title: "Parent or Guardian",
                  onPressed: () {
                    launchOnboarding(context, appState, Role.PARENT);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SquareGradientButton(
                  title: "Admitted Student",
                  onPressed: () {
                    launchOnboarding(context, appState, Role.ADMITTED_STUDENT);
                  },
                ),
                SquareGradientButton(
                  title: "Guest",
                  onPressed: () {
                    launchOnboarding(context, appState, Role.GUEST);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void launchOnboarding(
      BuildContext context, AppState appState, Role role) async {
    appState.role = role;

    Navigator.pushNamed(context, "/onboarding");
  }
}
