import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/widgets/my_day_assignment_card.dart';
import 'package:rutgers_flutter_mock/widgets/my_day_course_travel_directions_card.dart';

/// My Day page (shown only to current students)
class MyDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

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
