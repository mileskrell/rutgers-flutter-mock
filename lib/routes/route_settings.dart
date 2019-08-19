import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/models/home_page.dart';

/// A page where the user can configure app-wide settings
class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: <Widget>[
                  Text("Home page"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  DropdownButton<HomePage>(
                    value: appState.homePage,
                    items: <HomePage>[
                      if (appState.role.hasMyDay) HomePage.MY_DAY,
                      if (appState.role.hasMyDashboard)
                        HomePage.MY_DASHBOARD,
                      HomePage.MY_APPS,
//                      HomePage.BUS, // Commented out for now because the current Bus page opens in a new route
                    ].map((HomePage page) {
                      return new DropdownMenuItem<HomePage>(
                        value: page,
                        child: new Text(page.title),
                      );
                    }).toList(),
                    onChanged: (newHomePage) {
                      appState.homePage = newHomePage;
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
