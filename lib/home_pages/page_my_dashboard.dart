import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rutgers_basic_flutter_mock/app_state.dart';
import 'package:rutgers_basic_flutter_mock/resources.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_webview.dart';
import 'package:rutgers_basic_flutter_mock/widgets/eye-reveal.dart';

class Grade {
  String course;
  String subject;
  String grade;

  Grade(this.course, this.subject, this.grade);
}

class MyDashboard extends StatelessWidget {
  final grades = [
    Grade("Intro to Carribean Studies", "Latino and Hispanic Carribean Studies",
        "A"),
    Grade("The Byrne Seminars", "Arts and Sciences", "B"),
    Grade("Calc II Math/Phys", "Mathematics", "C"),
    Grade("Computer Architecture", "Computer Science", "D"),
    Grade("Theater Appreciation", "Theater", "E"),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (appState.userType == UserType.CURRENT_STUDENT) {
      return ListView(children: [
        Card(
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage: AssetImage("assets/miles_profile.png")),
            title: Text("Miles Krell"),
          ),
        ),
        Card(
          child: ExpansionTile(
              title: Text("My Schedule", style: TextStyle(color: pantone186)),
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
              title: Text("My Degree", style: TextStyle(color: pantone186)),
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
              title: Text("My Grades", style: TextStyle(color: pantone186)),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Log in with NetID to view My Dashboard",
              style: bigTextStyle,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            RaisedButton(
              child: Text("Log in with NetID", style: bigTextStyle),
              onPressed: () async {
                await Navigator.push<bool>(context,
                    MaterialPageRoute(builder: (context) {
                      return WebViewRoute(
                          "https://cas.rutgers.edu/login?renew=true&service=https://my.rutgers.edu/portal/Login",
                          "Log in with NetID");
                    }));

                appState.userType = UserType.CURRENT_STUDENT;

                Navigator.pushReplacementNamed(context, "/home");
                    () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool("has_completed_tutorial", true);
                }();
              },
            ),
          ],
        ),
      ),
    );
  }
}
