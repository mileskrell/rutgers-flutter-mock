import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/home_pages/page_bus/page_bus.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_apps/page_my_apps.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_dashboard.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_day.dart';
import 'package:rutgers_flutter_mock/resources.dart';

/// The main route of the app, containing multiple pages and a bottom
/// navigation bar.
///
/// Depending on the [Role] of the user logged in, different pages can be shown.
/// Currently, "My Day" and "My Dashboard" are only shown to current students.
///
/// The app bar contains items for logging out and re-showing the tutorial.
class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeRoute> {
  AppState appState;

  var currentPageIndex = 0;

  var currentlySearching = false;
  String searchText = "";

  List<BottomNavigationBarItem> bottomNavBarItems;
  List<Widget> pages;
  PopupMenuButton popupMenuButton;

  AppBar appBar;

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);

    pages = <Widget>[
      if (appState.role == Role.CURRENT_STUDENT) MyDay(),
      if (appState.role == Role.CURRENT_STUDENT) MyDashboard(),
      MyApps(searchText),
      Bus(),
    ];

    bottomNavBarItems = [
      if (appState.role == Role.CURRENT_STUDENT)
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), title: Text("My Day")),
      if (appState.role == Role.CURRENT_STUDENT)
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text("My Dashboard")),
      BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text("My Apps")),
      BottomNavigationBarItem(
          icon: Icon(Icons.directions_bus), title: Text("Bus")),
    ];

    popupMenuButton ??= PopupMenuButton<String>(
      itemBuilder: (context) {
        return [
          PopupMenuItem<String>(
            value: "tutorial",
            child: Text("View tutorial again"),
          ),
          PopupMenuItem<String>(
            value: "log_out",
            child: Text("Log out"),
          ),
        ];
      },
      onSelected: (tag) {
        switch (tag) {
          case "tutorial":
            Navigator.pushReplacementNamed(context, "/onboarding");
            break;
          case "log_out":
            // The login page will log out the user, so it doesn't happen
            // while still on this page.
            Navigator.pushReplacementNamed(context, "/login");
            break;
        }
      },
    );

    setAppBarState();

    return Scaffold(
      appBar: appBar,
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

  void onPressSearch() {
    currentlySearching = !currentlySearching;
    if (!currentlySearching) {
      searchText = "";
    }
    setAppBarState();
  }

  void setAppBarState() {
    if (!((bottomNavBarItems[currentPageIndex].title as Text).data ==
        "My Apps")) {
      setState(() {
        appBar = AppBar(
          title: bottomNavBarItems[
                  currentPageIndex < pages.length ? currentPageIndex : 0]
              .title,
          actions: [popupMenuButton],
        );
      });
      return;
    }
    if (currentlySearching) {
      setState(() {
        appBar = AppBar(
          leading: IconButton(
              tooltip: "Close",
              icon: Icon(Icons.close),
              onPressed: () => onPressSearch()),
          title: TextField(
            autofocus: true,
            autocorrect: false,
            style: TextStyle(color: Colors.white),
            onChanged: (input) {
              setState(() {
                searchText = input;
              });
            },
          ),
        );
      });
    } else {
      setState(() {
        appBar = AppBar(
          title: bottomNavBarItems[
                  currentPageIndex < pages.length ? currentPageIndex : 0]
              .title,
          actions: <Widget>[
            IconButton(
                tooltip: "Search",
                icon: Icon(Icons.search),
                onPressed: () => onPressSearch()),
            popupMenuButton,
          ],
        );
      });
    }
  }
}
