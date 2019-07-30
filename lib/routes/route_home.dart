import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_bus/page_bus.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_my_apps.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_my_dashboard.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_my_day.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_state.dart';
import '../resources.dart';

class HomeRoute extends StatefulWidget {
  final AppState appState;

  HomeRoute(this.appState);

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
    final pages = <Widget>[
      if (widget.appState.userType != UserType.COMMUNITY_ID)
        MyDay(widget.appState),
      if (widget.appState.userType != UserType.COMMUNITY_ID)
        MyDashboard(widget.appState),
      MyApps(),
      Bus(),
    ];

    bottomNavBarItems = [
      if (widget.appState.userType != UserType.COMMUNITY_ID)
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), title: Text("My Day")),
      if (widget.appState.userType != UserType.COMMUNITY_ID)
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text("My Dashboard")),
      BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text("My Apps")),
      BottomNavigationBarItem(
          icon: Icon(Icons.directions_bus), title: Text("Bus")),
    ];

    final logOutString = "Log out (currently ${widget.appState.userType})";

    return Scaffold(
      appBar: AppBar(
        title: bottomNavBarItems[
                currentPageIndex < pages.length ? currentPageIndex : 0]
            .title,
        actions: <Widget>[
          if (widget.appState.userType != null)
            IconButton(
              icon: Icon(Icons.person_outline),
              tooltip: logOutString,
              onPressed: () async {
                setState(() {
                  widget.appState.userType = null;
                });
                final prefs = await SharedPreferences.getInstance();
                unawaited(prefs.setString("user_type", null));
              },
            ),
          IconButton(
            icon: Icon(Icons.help_outline),
            tooltip: "Reset tutorial status",
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              unawaited(prefs.setBool("has_completed_tutorial", null));
            },
          )
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
