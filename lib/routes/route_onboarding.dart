import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rutgers_flutter_mock/app_state.dart';
import 'package:rutgers_flutter_mock/resources.dart';
import 'package:rutgers_flutter_mock/widgets/onboarding_login_page.dart';

/// The onboarding route
class OnboardingRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OnboardingState();
}

class OnboardingState extends State<OnboardingRoute> {
  var currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

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
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Welcome to the Rutgers app,\n${appState.role.title}!",
                  style: bigTextStyle,
                  textAlign: TextAlign.center,
                ),
              )),
              Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Some onboarding content based on your role",
                  style: bigTextStyle,
                  textAlign: TextAlign.center,
                ),
              )),
              OnboardingLoginPage(),
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
