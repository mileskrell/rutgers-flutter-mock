import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/models/role.dart';
import 'package:rutgers_flutter_mock/widgets/link_text.dart';

/// Data class representing a My Apps "App".
///
/// TODO: Maybe add an "info" button to this widget, like on my.rutgers.edu
class App {
  final String sharedPrefsTag;

  /// A title to display for the App (displayed in AppWidget)
  final String title;

  /// A URL that should be opened when the App is opened
  final String url;

  /// A module that should be opened when the App is opened
  final String moduleTag;

  /// A Material Design icon (from [Icons])
  final IconData iconData;

  /// A string for an asset that can be used as an icon
  final String assetString;

  /// Whether this App has been recently added to My Apps
  final bool isNew;

  /// Whether the App is inactive
  final bool inactive;

  /// An explanation for why the App is inactive
  /// (required if and only if the App is inactive)
  final LinkText inactiveExplanation;

  /// A list of [Role.singular], defining the roles that this app can be used by.
  final Set<String> roles;

  const App({
    @required this.sharedPrefsTag,
    @required this.title,
    this.url,
    this.moduleTag,
    this.iconData,
    this.assetString,
    this.isNew = false,
    this.inactive = false,
    this.inactiveExplanation,
    this.roles = allSingulars,
  })  : assert(title != null, "App \"$title\" doesn't provide a title"),
        assert(url != null || moduleTag != null,
            "App \"$title\" doesn't provide a URL or module tag"),
        assert(url == null || moduleTag == null,
            "App \"$title\" provides both URL and module tag"),
        assert(iconData != null || assetString != null,
            "App \"$title\" doesn't provide icon data or asset string"),
        assert((iconData == null || assetString == null),
            "App \"$title\" provides both icon data and asset string"),
        assert(!inactive || inactiveExplanation != null,
            "App $title is inactive, but no inactiveExplanation was provided");
}
