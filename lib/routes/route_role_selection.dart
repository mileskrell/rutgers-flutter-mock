import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/models/role.dart';
import 'package:rutgers_flutter_mock/resources.dart';
import 'package:rutgers_flutter_mock/widgets/gradient_button.dart';

/// On first run, this is the first route loaded after SharedPrefsCheckRoute.
/// This route prompts the user to select their role (student, faculty, etc.).
/// Once they make a choice, it opens OnboardingRoute (which will contain
/// different content depending on their chosen role).
///
/// The user will be able to return here from OnboardingRoute, in case they
/// chose incorrectly.
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
                GradientButton(
                  title: "Student",
                  isBigSquare: true,
                  onPressed: () {
                    launchOnboarding(context, appState, Role.CURRENT_STUDENT);
                  },
                ),
                GradientButton(
                  title: "Staff",
                  isBigSquare: true,
                  onPressed: () {
                    launchOnboarding(context, appState, Role.STAFF);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GradientButton(
                  title: "Faculty",
                  isBigSquare: true,
                  onPressed: () {
                    launchOnboarding(context, appState, Role.FACULTY);
                  },
                ),
                GradientButton(
                  title: "Parent or Guardian",
                  isBigSquare: true,
                  onPressed: () {
                    launchOnboarding(context, appState, Role.PARENT);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GradientButton(
                  title: "Admitted Student",
                  isBigSquare: true,
                  onPressed: () {
                    launchOnboarding(context, appState, Role.ADMITTED_STUDENT);
                  },
                ),
                GradientButton(
                  title: "Guest",
                  isBigSquare: true,
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
    appState.loggedIn = false;
    appState.hasCompletedTutorial = false;
    appState.setHomePageFromTitle(null);
    appState.favoriteApps = appState.role.defaultFavoriteApps;

    Navigator.pushNamed(context, "/onboarding");
  }
}
