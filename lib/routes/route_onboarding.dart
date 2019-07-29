import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources.dart' show bigTextStyle, pantone186;

class OnboardingRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OnboardingState();
}

class OnboardingState extends State<OnboardingRoute> {
  var currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Onboarding page"),
      ),
      body: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (newPageIndex) => setState(() {
              currentPageIndex = newPageIndex;
            }),
            children: <Widget>[
              Center(
                  child: Text(
                    "Onboarding content",
                    style: bigTextStyle,
                  )),
              Center(
                  child: Text("More onboarding content", style: bigTextStyle)),
              Center(
                  child: RaisedButton(
                    child: Text("Go to main page", style: bigTextStyle),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/home");
                      () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool("has_completed_tutorial", true);
                      }();
                    },
                  ))
            ],
          ),
          Align(
            alignment: Alignment(0, 0.75),
            child: DotsIndicator(
              dotsCount: 3,
              position: currentPageIndex,
              decorator: DotsDecorator(activeColor: pantone186),
            ),
          )
        ],
      ),
    );
  }
}
