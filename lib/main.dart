import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => OnboardingRoute(),
        "/second": (context) => MainRoute()
      },
      initialRoute: "/",
    );
  }
}

class OnboardingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Onboarding page"),
      ),
      body: Builder(
        builder: (context) {
          return Center(
              child: RaisedButton(
            child: Text("Go to main page"),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/second");
            },
          ));
        },
      ),
    );
  }
}

class MainRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main page"),
      ),
      body: Builder(
        builder: (context) {
          return Center(
              child: Text(
                  "This is the main page. If you try to go back, the app will close!"));
        },
      ),
    );
  }
}
