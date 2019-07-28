import 'package:flutter/material.dart';

class Bus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BusState();
}

class BusState extends State<Bus> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("This is the bus page"));
  }
}
