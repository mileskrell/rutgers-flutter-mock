import 'package:flutter/material.dart';

class MyDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyDashboardState();
}

class MyDashboardState extends State<MyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
            "This is the My Dashboard page"));
  }
}
