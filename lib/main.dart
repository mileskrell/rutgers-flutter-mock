import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const appTitle = "Rutgers";
final pantone186 = const Color(0xffcc0033);
final bigTextStyle = const TextStyle(fontSize: 22);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
          primaryColor: pantone186,
          accentColor: pantone186 // TODO Maybe change this?
          ),
      routes: {
        "/": (context) => OnboardingRoute(),
        "/second": (context) => MainRoute()
      },
      initialRoute: "/",
    );
  }
}

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
                  Navigator.pushReplacementNamed(context, "/second");
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

class MainRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Center(
          child: Text(
              "This is the main page. If you try to go back, the app will close!")),
    );
  }
}
