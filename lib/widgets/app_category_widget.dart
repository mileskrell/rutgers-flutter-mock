import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/models/app_category.dart';
import 'package:rutgers_flutter_mock/widgets/app_widget.dart';

class AppCategoryWidget extends StatelessWidget {
  final AppCategory appCategory;

  AppCategoryWidget(this.appCategory);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(appCategory.title),
      children: appCategory.apps.map((app) => AppWidget(app)).toList(),
    );
  }
}
