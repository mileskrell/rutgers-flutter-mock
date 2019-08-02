import 'package:flutter/material.dart';

import 'package:rutgers_basic_flutter_mock/resources.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_webview.dart';

class AssignmentCard extends StatelessWidget {
  final String time;
  final String course;
  final String assignmentName;
  final String assignmentUrl;

  AssignmentCard(
      {this.time, this.course, this.assignmentName, this.assignmentUrl});

  @override
  Widget build(BuildContext context) {
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
              ),
            ],
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.assignment),
              backgroundColor: Colors.transparent,
              // so there's no circle; this just makes the bus icon centered
              foregroundColor: pantone431,
            ),
            title: Text("Assignment due"),
            subtitle: Text(course + ":\n" + assignmentName),
            isThreeLine: true,
            onTap: () {
              Navigator.push<Null>(context,
                  MaterialPageRoute(builder: (context) {
                return WebViewRoute("data:text/html,<!DOCTYPE html><p>This would be the Canvas, Sakai, etc. page for the assignment</p>", assignmentName);
              }));
            },
          ),
        ],
      ),
    );
  }
}
