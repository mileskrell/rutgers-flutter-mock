import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  final String title;

  HomeRoute(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: Text(
              "This is the main page. If you try to go back, the app will close!")),
    );
  }
}
