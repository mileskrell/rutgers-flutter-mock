import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_webview.dart';
import 'package:rutgers_basic_flutter_mock/widgets/eye-reveal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_state.dart';
import '../resources.dart';

class MyDashboard extends StatefulWidget {
  final AppState appState;

  MyDashboard(this.appState);

  @override
  State<StatefulWidget> createState() => MyDashboardState();
}

class MyDashboardState extends State<MyDashboard> {
  @override
  Widget build(BuildContext context) {
    if (widget.appState.userType == UserType.NETID) {
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<Null>(
                                builder: (context) => WebViewRoute(
                                    "https://dn.rutgers.edu",
                                    "Degree Navigator")));
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/fa_compass_431.png",
                            width: 25,
                          ),
                          Text(
                            "Degree Navigator",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<Null>(
                                builder: (context) => WebViewRoute(
                                    "https://transcripts.rutgers.edu/transcripts/studentTranscriptGateway.login",
                                    "Transcript Request / Enrollment Verification")));
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/fa_list_alt_431.png",
                            width: 25,
                          ),
                          Text(
                            "Request transcript\nor verification",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<Null>(
                                builder: (context) => WebViewRoute(
                                    "https://www.ugadmissions.rutgers.edu/schooltoschool/",
                                    "Apply for school to school transfer")));
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/fa_exchange_alt_431.png",
                            width: 25,
                          ),
                          Text(
                            "Apply for school \nto school transfer",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<Null>(
                                builder: (context) => WebViewRoute(
                                    "https://grad.admissions.rutgers.edu/Diploma/Login.aspx?ReturnUrl=%2fDiploma",
                                    "Apply for diploma")));
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/fa_graduation_cap_431.png",
                            width: 25,
                          ),
                          Text("Apply for diploma"),
                        ],
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
                  border: TableBorder.all(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(children: <Widget>[
                      Center(
                        child: Text("Course",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Center(
                        child: Text("Subject",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Center(
                        child: Text("Grade",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ]),
                    TableRow(children: <Widget>[
                      Center(
                        child: Text(
                          "Intro to Carribean Studies",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Latino And Hispanic Caribbean Studies",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: EyeReveal("A"),
                      ),
                    ]),
                    TableRow(children: <Widget>[
                      Center(
                        child: Text(
                          "The Byrne Seminars",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Arts and Sciences",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: EyeReveal("B"),
                      ),
                    ]),
                    TableRow(children: <Widget>[
                      Center(
                        child: Text(
                          "Calc II Math/Phys",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Mathematics",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Center(
                          child: EyeReveal("C"),
                        ),
                      ),
                    ]),
                    TableRow(children: <Widget>[
                      Center(
                        child: Text(
                          "Computer Architecture",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Computer Science",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: EyeReveal("D"),
                      ),
                    ]),
                    TableRow(children: <Widget>[
                      Center(
                        child: Text(
                          "Theater Appreciation",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Theater",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: EyeReveal("E"),
                      ),
                    ])
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
              ]),
        ),
        Card(
          child: ExpansionTile(
              title: Text("My Schedule", style: TextStyle(color: pantone186)),
              initiallyExpanded: true,
              children: <Widget>[
                GestureDetector(
                  child: Text("WebReg",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: pantone186)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<Null>(
                            builder: (context) => WebViewRoute(
                                "https://sims.rutgers.edu/webreg/", "WebReg")));
                  },
                ),
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
                      "MW: LSH-A142 12:00pm-1:20pm\nTh: BE-121 5:00 PM - 6:20 PM"),
                ),
                ListTile(
                  title: Text("Computer Architecture"),
                  isThreeLine: true,
                  subtitle: Text(
                      "TF: 8:40 AM - 10:00 AM @ ARC-103\nT: 6:55 PM - 7:50 PM @ COR-101"),
                ),
                ListTile(
                  title: Text("Theater Appreciation"),
                  subtitle: Text("Hill 103: TTh 3:10pm-5:30pm"),
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

                setState(() {
                  widget.appState.userType = UserType.NETID;
                });

                unawaited(Navigator.pushReplacementNamed(context, "/home"));
                unawaited(() async {
                  final prefs = await SharedPreferences.getInstance();
                  unawaited(prefs.setString("user_type", "net"));
                  unawaited(prefs.setBool("has_completed_tutorial", true));
                }());
              },
            ),
          ],
        ),
      ),
    );
  }
}
