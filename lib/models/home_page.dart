import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/home_pages/page_bus/page_bus.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_dashboard.dart';
import 'package:rutgers_flutter_mock/home_pages/page_my_day.dart';

/// A page in HomeRoute, accessed through the bottom navigation bar,
/// that the user can set as their home page
class HomePage {
  static const MY_DAY = HomePage(
    title: "My Day",
    associatedPage: MyDay,
  );
  static const MY_DASHBOARD = HomePage(
    title: "My Dashboard",
    associatedPage: MyDashboard,
  );
  static const MY_APPS = HomePage(
    title: "My Apps",
    associatedPage: TabBarView,
  );
  static const BUS = HomePage(
    title: "Bus",
    associatedPage: Bus,
  );

  final String title;
  final Type associatedPage;

  const HomePage({this.title, this.associatedPage});

  static final pages = Map<String, HomePage>.fromIterable(
    <HomePage>[
      MY_DAY,
      MY_DASHBOARD,
      MY_APPS,
      BUS,
    ],
    key: (dynamic element) => (element as HomePage).title,
  );
}
