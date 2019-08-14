import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/widgets/link_text.dart';

/// Data class representing a My Apps "App".
///
/// TODO: Modify this so it can hold a reference to a built-in module instead of a URL
///
/// TODO: Maybe add an "info" button to this widget, like on my.rutgers.edu
class App {
  final String tag;

  final String title;
  final String url;

  final IconData iconData;
  final String assetString;
  final bool inactive;
  final LinkText inactiveExplanation;

  App(
      {@required this.tag,
      @required this.title,
      @required this.url,
      this.iconData,
      this.assetString,
      this.inactive = false,
      this.inactiveExplanation}) {
    if (title == null || url == null) {
      throw "App \"$title\" must provide both a title and URL";
    }

    if (iconData == null && assetString == null) {
      throw "App \"$title\" must provide either icon data or asset string";
    }

    if (inactive && inactiveExplanation == null) {
      throw "Inactive app \"$title\" must provide a reason for being inactive";
    }
  }
}
