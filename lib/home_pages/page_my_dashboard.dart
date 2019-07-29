import 'package:flutter/material.dart';
import 'package:rutgers_basic_flutter_mock/routes/route_webview.dart';
import 'package:rutgers_basic_flutter_mock/widgets/eye-reveal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_state.dart';
import '../resources.dart';

class MyDashboard extends StatefulWidget {
  AppState appState;

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
              title: Text("My Grades"),
              initiallyExpanded: true,
              children: <Widget>[
                Table(
                  border: TableBorder.all(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
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
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
              ]),
        ),
        Card(
          child: ExpansionTile(
              title: Text("My Schedule", style: TextStyle(color: pantone186)),
              initiallyExpanded: true,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Text("WebReg",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: pantone186)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebViewRoute(
                                      "https://sims.rutgers.edu/webreg/",
                                      "WebReg")));
                        },
                      ),
                      GestureDetector(
                        child: Text("Degree Navigator",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: pantone186)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebViewRoute(
                                      "https://nbdn.rutgers.edu/",
                                      "Degree Navigator")));
                        },
                      )
                    ]),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Log in with NetID to view My Dashboard",
            style: bigTextStyle,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          RaisedButton(
            child: Text("Log in with NetID", style: bigTextStyle),
            onPressed: () async {
              var loggedIn = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return WebViewRoute(
                    "https://cas.rutgers.edu/login?renew=true&service=https://my.rutgers.edu/portal/Login",
                    "Log in with NetID");
              }));

              setState(() {
                widget.appState.userType = UserType.NETID;
              });

              Navigator.pushReplacementNamed(context, "/home");
              () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString("user_type", "net");
                prefs.setBool("has_completed_tutorial", true);
              }();
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
          ),
        ],
      ),
    );
  }
}
