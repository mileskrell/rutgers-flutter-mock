import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/widgets/link_text.dart';

/// Data class representing a My Apps "App".
///
/// TODO: Modify this so it can hold a reference to a built-in module instead of a URL
///
/// TODO: Maybe add an "info" button to this widget, like on my.rutgers.edu
class App {
  final String sharedPrefsTag;

  final String title;
  final String url;

  final IconData iconData;
  final String assetString;
  final bool isNew;
  final bool inactive;
  final LinkText inactiveExplanation;

  const App(
      {@required this.sharedPrefsTag,
      @required this.title,
      @required this.url,
      this.iconData,
      this.assetString,
      this.isNew = false,
      this.inactive = false,
      this.inactiveExplanation})
      : assert(title != null, "App \"$title\" doesn't provide a title"),
        assert(url != null, "App \"$title\" doesn't provide a URL"),
        assert(iconData != null || assetString != null,
            "App \"$title\" doesn't provide icon data or asset string"),
        assert((iconData == null || assetString == null),
            "App \"$title\" provides both icon data and asset string"),
        assert(!inactive || inactiveExplanation != null,
            "App $title is inactive, but no inactiveExplanation was provided");
}
