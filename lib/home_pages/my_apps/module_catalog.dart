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

const scheduleOfClasses = App(
  sharedPrefsTag: "module_schedule_of_classes",
  title: "Schedule of Classes",
  moduleTag: "schedule_of_classes",
  iconData: Icons.calendar_today,
);

const news = App(
  sharedPrefsTag: "module_news",
  title: "News",
  moduleTag: "news",
  iconData: Icons.library_books,
  isNew: true,
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const _allModules = {
  places,
  scheduleOfClasses,
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
  scheduleOfClasses,
  places,
  news,
];

const facultyModules = [
  news,
  places,
  scheduleOfClasses,
];

const staffModules = [
  places,
  scheduleOfClasses,
  news,
];

const admittedStudentModules = [
  places,
  news,
  scheduleOfClasses,
];

const parentModules = [
  news,
  places,
  scheduleOfClasses,
];

const alumnusModules = [
  places,
  scheduleOfClasses,
  news,
];

const guestModules = [
  places,
  scheduleOfClasses,
  news,
];
