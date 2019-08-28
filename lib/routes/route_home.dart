import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/home_pages/bus/bus.dart';
import 'package:rutgers_flutter_mock/home_pages/my_apps/my_apps_featured.dart';
import 'package:rutgers_flutter_mock/home_pages/my_apps/my_apps_for_you.dart';
import 'package:rutgers_flutter_mock/home_pages/my_apps/my_apps_all.dart';
import 'package:rutgers_flutter_mock/home_pages/my_apps/my_apps_favorites.dart';
import 'package:rutgers_flutter_mock/home_pages/my_apps/my_apps_search.dart';
import 'package:rutgers_flutter_mock/home_pages/my_dashboard.dart';
import 'package:rutgers_flutter_mock/home_pages/my_day.dart';
import 'package:rutgers_flutter_mock/home_pages/ru_search.dart';
import 'package:rutgers_flutter_mock/models/home_page.dart';
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
      if (appState.role.hasMyDay) MyDay(),
      if (appState.role.hasMyDashboard) MyDashboard(),
      TabBarView(
        children: <Widget>[
          MyAppsFeatured(),
          MyAppsFavorites(),
          MyAppsForYou(),
          MyAppsAll(),
        ],
      ),
      RuSearch(),
      Bus(),
    ];

    if (!hasSeenHomePage) {
      hasSeenHomePage = true;
      switch (appState.homePage) {
        case HomePage.MY_DAY:
          currentPageIndex =
              pages.indexOf(pages.where((it) => it is MyDay).toList()[0]);
          break;
        case HomePage.MY_DASHBOARD:
          currentPageIndex =
              pages.indexOf(pages.where((it) => it is MyDashboard).toList()[0]);
          break;
        case HomePage.MY_APPS:
          currentPageIndex =
              pages.indexOf(pages.where((it) => it is TabBarView).toList()[0]);
          break;
        case HomePage.BUS:
          currentPageIndex =
              pages.indexOf(pages.where((it) => it is Bus).toList()[0]);
          break;
      }
    }

    bottomNavBarItems = [
      if (appState.role.hasMyDay)
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          title: Text(HomePage.MY_DAY.title),
        ),
      if (appState.role.hasMyDashboard)
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text(HomePage.MY_DASHBOARD.title),
        ),
      BottomNavigationBarItem(
        icon: Icon(Icons.apps),
        title: Text(HomePage.MY_APPS.title),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        title: Text(HomePage.RU_SEARCH.title),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.directions_bus),
        title: Text(HomePage.BUS.title),
      ),
    ];

    popupMenuButton ??= PopupMenuButton<String>(
      tooltip: "Other menu items",
      itemBuilder: (context) {
        return [
          if (appState.loggedIn)
            PopupMenuItem<String>(
              value: "settings",
              child: ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings),
              ),
            ),
          PopupMenuItem<String>(
            value: "tutorial",
            child: ListTile(
              title: Text("Replay tutorial"),
              leading: Icon(Icons.help),
            ),
          ),
          PopupMenuItem<String>(
            value: "change_role",
            child: ListTile(
              title: Text("Change role"),
              leading: Icon(Icons.person),
            ),
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

    // This controller is used for MyApps
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: appBar,
        body: currentlySearching
            ? MyAppsSearch(searchText)
            : pages[currentPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: pantone431,
          selectedItemColor: pantone186,
          currentIndex: currentPageIndex,
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
        HomePage.MY_APPS.title)) {
      setState(() {
        appBar = AppBar(
          title: bottomNavBarItems[currentPageIndex].title,
          actions: [popupMenuButton],
          // No tab bar, since we're not on the My Apps page
        );
      });
      return;
    }

    // If we're here, we're on the My Apps page

    final tabBar = TabBar(
      tabs: <Widget>[
        Tab(text: "Featured", icon: Icon(Icons.star)),
        Tab(text: "Favorites", icon: Icon(Icons.favorite)),
        Tab(text: "For You", icon: Icon(Icons.face)),
        Tab(text: "All", icon: Icon(Icons.category)),
      ],
    );

    if (currentlySearching) {
      setState(() {
        appBar = AppBar(
          leading: IconButton(
              tooltip: "Close search",
              icon: Icon(Icons.close),
              onPressed: () => onPressSearch()),
          title: TextField(
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              labelText: "Search My Apps",
              border: InputBorder.none,
            ),
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
          title: bottomNavBarItems[currentPageIndex].title,
          actions: <Widget>[
            IconButton(
                tooltip: "Search My Apps",
                icon: Icon(Icons.search),
                onPressed: () => onPressSearch()),
            popupMenuButton,
          ],
          bottom: tabBar,
        );
      });
    }
  }
}
