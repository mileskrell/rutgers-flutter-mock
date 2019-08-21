import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/models/app.dart';

/// All the module [App]s are defined here

const places = App(
  sharedPrefsTag: "module_places",
  title: "Places",
  moduleTag: "places",
  iconData: Icons.map,
  isNew: true,
);

const bus = App(
  sharedPrefsTag: "module_bus",
  title: "Bus",
  moduleTag: "bus",
  iconData: Icons.directions_bus,
);

const news = App(
  sharedPrefsTag: "module_news",
  title: "News",
  moduleTag: "news",
  iconData: Icons.library_books,
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const _allModules = {
  places,
  bus,
  news,
};

/// Map of [App.sharedPrefsTag] to [App]
final allModules = Map<String, App>.fromIterable(
  _allModules,
  key: (dynamic element) => (element as App).sharedPrefsTag,
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// Module order for each role

const currentStudentModules = [
  places,
  bus,
];

const facultyModules = [
  places,
  bus,
];

const staffModules = [
  places,
  bus,
];

const admittedStudentModules = [
  places,
  bus,
];

const parentModules = [
  places,
  bus,
];

const alumnusModules = [
  places,
  bus,
];

const guestModules = [
  places,
  bus,
];
