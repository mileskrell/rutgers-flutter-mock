import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/home_pages/my_apps/link_catalog.dart';
import 'package:rutgers_flutter_mock/home_pages/my_apps/module_catalog.dart';
import 'package:rutgers_flutter_mock/models/app_category.dart';
import 'package:rutgers_flutter_mock/routes/route_webview.dart';
import 'package:rutgers_flutter_mock/widgets/app_category_widget.dart';

/// The Featured tab in My Apps
class MyAppsFeatured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push<Null>(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WebViewRoute(
                        "data:text/html,<!DOCTYPE html><p>This would open the Rutgers Day module (or maybe even the standalone Rutgers Day app, if that still exists)</p>",
                        "Rutgers Day");
                  },
                ),
              );
            },
            child: Image(
              width: 550,
              fit: BoxFit.fitHeight,
              image: AssetImage("assets/rutgers_day.png"),
            ),
          ),
        ),
        AppCategoryWidget(AppCategory(
          title: "New",
          apps: allLinks.values.where((app) => app.isNew).toList(),
        )),
      ],
    );
  }
}
