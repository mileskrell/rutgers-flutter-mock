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

  /// This will be set to the index of the user's chosen [HomePage] when [build]
  /// runs for the first time.
  int currentPageIndex;

  var currentlySearching = false;
  String searchText = "";

  List<BottomNavigationBarItem> bottomNavBarItems;
  List<Widget> pages;
  PopupMenuButton popupMenuButton;

  AppBar appBar;

  bool hasSeenHomePage = false;

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);

    pages = <Widget>[
      if (roleHasMyDay(appState.role)) MyDay(),
      if (roleHasMyDashboard(appState.role)) MyDashboard(),
      MyApps(searchText),
      Bus(),
    ];

    if (!hasSeenHomePage) {
      hasSeenHomePage = true;
      switch (appState.homePage) {
        case MY_DAY:
          currentPageIndex =
              pages.indexOf(pages.where((it) => it is MyDay).toList()[0]);
          break;
        case MY_DASHBOARD:
          currentPageIndex =
              pages.indexOf(pages.where((it) => it is MyDashboard).toList()[0]);
          break;
        case MY_APPS:
          currentPageIndex =
              pages.indexOf(pages.where((it) => it is MyApps).toList()[0]);
          break;
        case BUS:
          currentPageIndex =
              pages.indexOf(pages.where((it) => it is Bus).toList()[0]);
          break;
      }
    }

    bottomNavBarItems = [
      if (roleHasMyDay(appState.role))
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), title: Text("My Day")),
      if (roleHasMyDashboard(appState.role))
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text("My Dashboard")),
      BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text("My Apps")),
      BottomNavigationBarItem(
          icon: Icon(Icons.directions_bus), title: Text("Bus")),
    ];

    popupMenuButton ??= PopupMenuButton<String>(
      itemBuilder: (context) {
        return [
          if (appState.loggedIn)
            PopupMenuItem<String>(
              value: "settings",
              child: Text("Settings"),
            ),
          PopupMenuItem<String>(
            value: "tutorial",
            child: Text("View tutorial again"),
          ),
          PopupMenuItem<String>(
            value: "change_role",
            child: Text("Change role"),
          ),
        ];
      },
      onSelected: (tag) {
        switch (tag) {
          case "settings":
            Navigator.pushNamed(context, "/settings");
            break;
          case "tutorial":
            Navigator.pushNamed(context, "/onboarding");
            break;
          case "change_role":
            if (!appState.loggedIn) {
              // Don't confirm log out, because user isn't logged in
              appState.role = null;
              Navigator.pushReplacementNamed(context, "/roleSelection");
              break;
            }

            showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Change role?"),
                    content: SingleChildScrollView(
                      child: Text("This will also log you out from the app"),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("No"),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          appState.role = null;
                          Navigator.pushReplacementNamed(
                              context, "/roleSelection");
                        },
                        child: Text("Yes"),
                      )
                    ],
                  );
                });
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
          if (currentlySearching) {
            onPressSearch();
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
