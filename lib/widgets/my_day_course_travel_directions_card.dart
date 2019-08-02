import 'package:flutter/material.dart';

import 'package:rutgers_basic_flutter_mock/resources.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_webview.dart';

class CourseTravelDirectionsCard extends StatelessWidget {
  final String time;
  final String directionsString;
  final String course;
  final String courseTime;
  final String courseLocation;
  final bool takesBus;

  CourseTravelDirectionsCard(
      {this.time,
      this.directionsString,
      this.course,
      this.courseTime,
      this.courseLocation,
      this.takesBus});

  @override
  Widget build(BuildContext context) {
    Widget directionsTile;
    if (takesBus) {
      directionsTile = ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.directions_bus),
          backgroundColor: Colors.transparent,
          // so there's no circle; this just makes the icon centered
          foregroundColor: pantone431,
        ),
        title: Text(directionsString),
        subtitle: Text("by $time"),
      );
    } else {
      directionsTile = ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.directions_walk),
          backgroundColor: Colors.transparent,
          // so there's no circle; this just makes the icon centered
          foregroundColor: pantone431,
        ),
        title: Text(directionsString),
      );
    }

    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              Text(
                time,
                style: bigTextStyle.copyWith(color: pantone186),
              )
            ],
          ),
          directionsTile,
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              CircleAvatar(
                child: Icon(Icons.arrow_downward),
                backgroundColor: Colors.transparent,
                // so there's no circle; this just makes the icon centered
                foregroundColor: pantone431,
              )
            ],
          ),
          ListTile(
            title: Text(course),
            subtitle: Row(
              children: <Widget>[
                Text("$courseTime @ "),
                GestureDetector(
                  onTap: () {
                    Navigator.push<Null>(context,
                        MaterialPageRoute(builder: (context) {
                      return WebViewRoute(
                          "data:text/html,<!DOCTYPE html><p>This would open the Maps module with $courseLocation selected and options to get directions</p>",
                          courseLocation);
                    }));
                  },
                  child: Text(
                    courseLocation,
                    style: TextStyle(
                        color: pantone186,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
