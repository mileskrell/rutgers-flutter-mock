import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/widgets/link_text.dart';

/// Data class representing a My Apps "App".
///
/// TODO: Maybe add an "info" button to this widget, like on my.rutgers.edu
class App {
  final String sharedPrefsTag;

  final String title;
  final String url;
  final String moduleTag;

  final IconData iconData;
  final String assetString;
  final bool isNew;
  final bool inactive;
  final LinkText inactiveExplanation;

  const App(
      {@required this.sharedPrefsTag,
      @required this.title,
      this.url,
      this.moduleTag,
      this.iconData,
      this.assetString,
      this.isNew = false,
      this.inactive = false,
      this.inactiveExplanation})
      : assert(title != null, "App \"$title\" doesn't provide a title"),
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
