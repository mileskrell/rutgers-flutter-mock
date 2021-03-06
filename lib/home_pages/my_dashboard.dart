import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/models/role.dart';
import 'package:rutgers_flutter_mock/resources.dart';
import 'package:rutgers_flutter_mock/routes/route_webview.dart';
import 'package:rutgers_flutter_mock/widgets/eye-reveal.dart';
import 'package:rutgers_flutter_mock/widgets/gradient_button.dart';
import 'package:rutgers_flutter_mock/widgets/link_text.dart';
import 'package:rutgers_flutter_mock/widgets/my_dashboard_profile_card.dart';

/// The My Dashboard page
class MyDashboard extends StatelessWidget {
  final grades = [
    Grade("Intro to Carribean Studies", "Latino and Hispanic Carribean Studies",
        "A"),
    Grade("The Byrne Seminars", "Arts and Sciences", "B"),
    Grade("Calc II Math/Phys", "Mathematics", "C"),
    Grade("Computer Architecture", "Computer Science", "D"),
    Grade("Theater Appreciation", "Theater", "F"),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final loginMethod = appState.role.hasNetID ? netID : communityID;

    if (appState.loggedIn == false) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GradientButton(
                title: "Log in with $loginMethod to view My Dashboard",
                isBigSquare: true,
                size: 170,
                onPressed: () async {
                  await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewRoute(
                          appState.role.loginUrl, "Log in with $loginMethod"),
                    ),
                  );
                  appState.loggedIn = true;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
              ),
              GradientButton(
                title: "What's a $loginMethod?",
                isBigSquare: false,
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("What's a $loginMethod?"),
                        content:
                            LinkText(children: appState.role.loginExplanation),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Close"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    if (appState.role == Role.CURRENT_STUDENT) {
      return ListView(children: [
        ProfileCard("Miles Krell",
            assetName: "assets/profile_miles_student.png"),
        Card(
          child: ExpansionTile(
              title: Text("My Schedule"),
              initiallyExpanded: true,
              children: <Widget>[
                ListTile(
                  title: Text("Intro to Carribean Studies"),
                  subtitle: Text("MW: 1:10 PM - 2:30 PM @ HH-B2"),
                ),
                ListTile(
                  title: Text("The Byrne Seminars"),
                  subtitle: Text("T: 12:00 PM - 1:20 PM @ BME-128"),
                ),
                ListTile(
                  title: Text("Calc II Math/Phys"),
                  isThreeLine: true,
                  subtitle: Text(
                      "MW: 12:00 PM - 1:20 PM @ LSH-A142\nTh: 5:00 PM - 6:20 PM @ BE-121"),
                ),
                ListTile(
                  title: Text("Computer Architecture"),
                  isThreeLine: true,
                  subtitle: Text(
                      "TF: 8:40 AM - 10:00 AM @ ARC-103\nT: 6:55 PM - 7:50 PM @ COR-101"),
                ),
                ListTile(
                  title: Text("Theater Appreciation"),
                  subtitle: Text("TTh 3:10 PM - 5:30 PM @ HLL-103"),
                ),
              ]),
        ),
        Card(
          child: ExpansionTile(
              title: Text("My Degree"),
              initiallyExpanded: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    Text("Major(s): ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Unspecified (matriculating)"),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    Text("School: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("School of Arts and Sciences"),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "GPA\n(cumulative)",
                            textAlign: TextAlign.center,
                          ),
                          EyeReveal(
                            "3.333",
                            color: Colors.blue,
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "GPA\n(last term)",
                            textAlign: TextAlign.center,
                          ),
                          EyeReveal(
                            "3.444",
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "Degree\nCredits",
                            textAlign: TextAlign.center,
                          ),
                          EyeReveal(
                            "34.5",
                            color: Colors.green,
                          )
                        ],
                      ),
                    ]),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<Null>(
                                builder: (context) => WebViewRoute(
                                    "https://dn.rutgers.edu",
                                    "Degree Navigator")));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/fa_compass_431.png",
                              width: 30,
                            ),
                            Text(
                              "Degree Navigator",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<Null>(
                                builder: (context) => WebViewRoute(
                                    "https://transcripts.rutgers.edu/transcripts/studentTranscriptGateway.login",
                                    "Transcript Request / Enrollment Verification")));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/fa_list_alt_431.png",
                              width: 30,
                            ),
                            Text(
                              "Request transcript\nor verification",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<Null>(
                                builder: (context) => WebViewRoute(
                                    "https://www.ugadmissions.rutgers.edu/schooltoschool/",
                                    "Apply for school to school transfer")));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/fa_exchange_alt_431.png",
                              width: 30,
                            ),
                            Text(
                              "Apply for school \nto school transfer",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<Null>(
                                builder: (context) => WebViewRoute(
                                    "https://grad.admissions.rutgers.edu/Diploma/Login.aspx?ReturnUrl=%2fDiploma",
                                    "Apply for diploma")));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/fa_graduation_cap_431.png",
                              width: 30,
                            ),
                            Text("Apply for diploma"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
              ]),
        ),
        Card(
          child: ExpansionTile(
              title: Text("My Grades"),
              initiallyExpanded: true,
              children: <Widget>[
                Table(
                  border: TableBorder.all(color: Colors.transparent),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(children: <Widget>[
                      ...["Course", "Subject", "Grade"].map((text) {
                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(text,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        );
                      }),
                    ]),
                    ...grades.map((grade) {
                      return TableRow(children: [
                        ...[grade.course, grade.subject].map((text) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                text,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: EyeReveal(grade.grade),
                          ),
                        )
                      ]);
                    }),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
              ]),
        ),
      ]);
    }

    if (appState.role == Role.FACULTY) {
      return ListView(
        children: <Widget>[
          ProfileCard("Fred the faculty member",
              assetName: "assets/profile_fred_faculty_member.jpg"),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child:
                    Text("More faculty content goes here (Employee Dashboard)"),
              ),
            ),
          )
        ],
      );
    }

    if (appState.role == Role.STAFF) {
      return ListView(
        children: <Widget>[
          ProfileCard("Samantha the staff member",
              assetName: "assets/profile_samantha_staff_member.jpg"),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child:
                    Text("More staff content goes here (Employee Dashboard)"),
              ),
            ),
          )
        ],
      );
    }

    if (appState.role == Role.ADMITTED_STUDENT) {
      return ListView(
        children: <Widget>[
          ProfileCard("Annie the admitted student",
              assetName: "assets/profile_annie_admitted_student.jpg"),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                  "Should admitted students just see Enrollment Pathway instead of My Dashboard?"),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                  "Also, do admitted students log in with NetID or CommunityID?"),
            ),
          ),
        ],
      );
    }

    if (appState.role == Role.PARENT) {
      return ListView(
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text("Content for parent logged in with CommunityID"),
              ),
            ),
          )
        ],
      );
    }

    throw "Can't view My Dashboard unless student, faculty, staff, admitted student, or parent/guardian";
  }
}

/// Holds grades used in the My Grades table
class Grade {
  String course;
  String subject;
  String grade;

  Grade(this.course, this.subject, this.grade);
}
