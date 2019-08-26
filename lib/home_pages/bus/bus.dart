import 'dart:async';
import 'package:flutter/material.dart';

import 'package:rutgers_flutter_mock/home_pages/bus/model/bus_models.dart';
import 'package:rutgers_flutter_mock/home_pages/bus/repo/repository.dart';

/// This was copied over from
/// <https://github.com/mileskrell/basic-bus-tracker-flutter>.
/// That's why it's a separate route - because it does its own stuff with the
/// app bar, and that would have to be integrated with what's already there.
///
/// This whole module should be replaced with something with a map, of course.
///
/// Also there are memory leaks in here, because I don't really understand how
/// Flutter's widget lifecycle works yet.
class Bus extends StatefulWidget {
  @override
  BusState createState() => BusState();
}

class BusState extends State<Bus> with TickerProviderStateMixin {
  final String title = "Rutgers Bus Tracker";

  List<BusRoute> _routes;

  String _routeAgeTitle = "";

  // Stored so it can be canceled later
  Timer _ticker;

  TabController _tabController;

  var _refreshing = true;

  BusState() {
    loadRoutes();
  }

  Future<Null> loadRoutes() async {
    // This check, combined with the fact that "refreshing" is initially true,
    // prevents setState from being called immediately upon state creation,
    // which would cause an error (setState would be called before
    // the widget was mounted, it seems).
    if (!_refreshing) {
      safeSetState(() {
        _refreshing = true;
      });
    }

    final newRoutes = await fetchRoutes();
    safeSetState(() {
      _routeAgeTitle = "0 seconds since estimates fetched";
    });

    _ticker?.cancel();
    final updateTime = DateTime.now();

    _ticker = Timer.periodic(Duration(seconds: 1), (timer) {
      final secondsSinceRoutesFetched =
          DateTime.now().difference(updateTime).inSeconds;
      String newRouteAgeTitle;
      if (secondsSinceRoutesFetched == 1) {
        newRouteAgeTitle = "1 second since estimates fetched";
      } else {
        newRouteAgeTitle =
            "$secondsSinceRoutesFetched seconds since estimates fetched";
      }
      safeSetState(() {
        _routeAgeTitle = newRouteAgeTitle;
      });
    });

    // If the route the user had been viewing is also contained in the new data,
    // store its new position; otherwise, store -1.
    var newIndex = -1;
    if (_tabController != null && _routes.isNotEmpty && newRoutes.isNotEmpty) {
      final oldRouteName = _routes[_tabController.index].routeName;
      newIndex = newRoutes.indexOf(
          newRoutes.where((route) => route.routeName == oldRouteName).first);
    }

    safeSetState(() {
      // Save new routes
      _routes = newRoutes;

      if (newRoutes.isNotEmpty) {
        // Create new TabController
        _tabController = TabController(length: newRoutes.length, vsync: this)
          // Switch tabs to the route the user had been looking at (if still present)
          ..index = newIndex == -1 ? 0 : newIndex;
      }
    });

    safeSetState(() {
      _refreshing = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Routes list is null upon state initialization (routes haven't been
    // fetched yet).
    if (_routes == null) {
      return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(padding: EdgeInsets.all(8)),
              Text("Loading predictions...", style: TextStyle(fontSize: 22))
            ],
          )));
    }

    // Routes are present; display them
    if (_routes.isNotEmpty) {
      final tabs = _routes
          .map((route) => RefreshIndicator(
                onRefresh: loadRoutes,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: route.stops.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Text(
                          route.stops[index].stopName,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        Text(
                          route.stops[index].getArrivalEstimateString(),
                          style: TextStyle(
                              color: Color(route.stops[index].getTextColor())),
                        )
                      ],
                    );
                  },
                ),
              ))
          .toList();

      return Scaffold(
        appBar: AppBar(
          title: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(title),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(_routeAgeTitle,
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ),
            ],
          ),
          bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: _routes
                  .map((route) => Tab(
                        text: route.routeName,
                      ))
                  .toList()),
        ),
        body: TabBarView(children: tabs, controller: _tabController),
      );
    }

    // If refreshing (and the routes list is empty), show a loading indicator
    if (_refreshing) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: CircularProgressIndicator(
            value: null,
          ),
        ),
      );
    }

    // Otherwise, tell user that there were no predictions
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(title),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(_routeAgeTitle,
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
          ],
        ),
        bottom: PreferredSize(
            // Seems like this is actually the best way to add padding below the title!
            child: Container(),
            preferredSize: Size.fromHeight(24)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("No predictions reported!\nTry again in a few minutes.",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
            ),
            IconButton(
              tooltip: "Refresh",
              icon: Icon(Icons.refresh),
              color: Colors.blueAccent,
              onPressed: loadRoutes,
            )
          ],
        ),
      ),
    );
  }

  // Temporary fix for memory leaks (maybe?)
  void safeSetState(void Function() func) {
    if (mounted) {
      setState(func);
    }
  }
}
