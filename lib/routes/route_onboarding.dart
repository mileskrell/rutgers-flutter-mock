import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/resources.dart';
import 'package:rutgers_flutter_mock/routes/route_login.dart';

/// The onboarding route
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
        title: Text("Rutgers"),
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
              LoginRoute(
                onboardingMode: true,
              ),
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
