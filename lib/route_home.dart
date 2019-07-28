import 'package:flutter/material.dart';

import 'package:rutgers_basic_flutter_mock/home_pages/page_bus.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_my_apps.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_my_dashboard.dart';
import 'package:rutgers_basic_flutter_mock/home_pages/page_my_day.dart';
import 'resources.dart';

class HomeRoute extends StatefulWidget {
  final bottomNavBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today), title: Text("My Day")),
    BottomNavigationBarItem(
        icon: Icon(Icons.person), title: Text("My Dashboard")),
    BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text("My Apps")),
    BottomNavigationBarItem(
        icon: Icon(Icons.directions_bus), title: Text("Bus")),
  ];

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeRoute> {
  var currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.bottomNavBarItems[currentPageIndex].title,
      ),
      body: <Widget>[
        MyDay(),
        MyDashboard(),
        MyApps(),
        Bus(),
      ][currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: pantone431,
        selectedItemColor: pantone186,
        showUnselectedLabels: true,
        currentIndex: currentPageIndex,
        onTap: (newIndex) => setState(() {
          currentPageIndex = newIndex;
        }),
        items: widget.bottomNavBarItems,
      ),
    );
  }
}
