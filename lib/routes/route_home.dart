import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_basic_flutter_mock/app_state.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_bus/page_bus.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_my_apps.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_my_dashboard.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_my_day.dart';
import 'package:rutgers_basic_flutter_mock/resources.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeRoute> {
  var currentPageIndex = 0;
  List<BottomNavigationBarItem> bottomNavBarItems;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final pages = <Widget>[
      if (appState.userType == UserType.CURRENT_STUDENT) MyDay(),
      if (appState.userType == UserType.CURRENT_STUDENT) MyDashboard(),
      MyApps(),
      Bus(),
    ];

    bottomNavBarItems = [
      if (appState.userType == UserType.CURRENT_STUDENT)
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), title: Text("My Day")),
      if (appState.userType == UserType.CURRENT_STUDENT)
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text("My Dashboard")),
      BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text("My Apps")),
      BottomNavigationBarItem(
          icon: Icon(Icons.directions_bus), title: Text("Bus")),
    ];

    final logOutString =
        "Log out (currently ${userTypeToString(appState.userType)})";

    return Scaffold(
      appBar: AppBar(
        title: bottomNavBarItems[
                currentPageIndex < pages.length ? currentPageIndex : 0]
            .title,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            tooltip: "Open tutorial again",
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/onboarding");
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: logOutString,
            onPressed: () async {
              appState.userType = null;
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
      body: pages[currentPageIndex < pages.length ? currentPageIndex : 0],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: pantone431,
        selectedItemColor: pantone186,
        showUnselectedLabels: true,
        currentIndex: currentPageIndex < pages.length ? currentPageIndex : 0,
        onTap: (newIndex) {
          if ((bottomNavBarItems[newIndex].title as Text).data == "Bus") {
            Navigator.pushNamed(context, "/bus");
          } else {
            setState(() {
              currentPageIndex = newIndex;
            });
          }
        },
        items: bottomNavBarItems,
      ),
    );
  }
}
