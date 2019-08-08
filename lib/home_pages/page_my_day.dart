import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/routes/route_webview.dart';
import 'package:rutgers_flutter_mock/widgets/gradient_button.dart';
import 'package:rutgers_flutter_mock/widgets/my_day_assignment_card.dart';
import 'package:rutgers_flutter_mock/widgets/my_day_course_travel_directions_card.dart';

/// My Day page (shown only to current students)
class MyDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (appState.loggedIn == false) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: GradientButton(
            title: "Log in with NetID to view My Day",
            isBigSquare: true,
            size: 170,
            onPressed: () async {
              await Navigator.push<bool>(context,
                  MaterialPageRoute(builder: (context) {
                return WebViewRoute(
                    "https://cas.rutgers.edu/login?renew=true&service=https://my.rutgers.edu/portal/Login",
                    "Log in with NetID");
              }));

              appState.loggedIn = true;
            },
          ),
        ),
      );
    }

    return Center(
      child: ListView(children: [
        CourseTravelDirectionsCard(
          time: "8:15 AM",
          directionsString: "Take A bus from SAC",
          course: "Computer Architecture",
          courseTime: "8:40 AM - 10:00 AM",
          courseLocation: "ARC-103",
          takesBus: true,
        ),
        AssignmentCard(
          time: "11:30 AM",
          course: "Calc II Math/Phys",
          assignmentName: "WebAssign 10.1 - 10.2",
        ),
        CourseTravelDirectionsCard(
          time: "8:15 AM",
          directionsString: "Walk to Biomedical Engineering building",
          course: "The Byrne Seminars",
          courseTime: "12:00 PM - 1:20 PM",
          courseLocation: "BME-128",
          takesBus: false,
        ),
        CourseTravelDirectionsCard(
          time: "6:55 PM",
          directionsString: "Walk to CoRE building",
          course: "Computer Architecture",
          courseTime: "6:55 PM - 7:50 PM",
          courseLocation: "COR-101",
          takesBus: false,
        ),
        AssignmentCard(
          time: "11:59 PM",
          course: "Introduction to Caribbean Studies",
          assignmentName: "Kingdom of this World guide questions",
        ),
      ]),
    );
  }
}
