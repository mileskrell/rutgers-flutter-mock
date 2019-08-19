import 'package:meta/meta.dart';

import 'package:rutgers_flutter_mock/models/app.dart';

/// Data class representing a My Apps [App] category
class AppCategory {
  final String title;
  final List<App> apps;

  const AppCategory({@required this.title, @required this.apps});
}
