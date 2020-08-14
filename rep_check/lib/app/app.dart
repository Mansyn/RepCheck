import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rep_check/state/shared_state.dart';
import 'package:rep_check/ui/home_page.dart';

class FlutterApp extends StatefulWidget {
  FlutterApp({
    @required this.state,
    @required this.appName,
  });
  final SharedState state;
  final String appName;

  @override
  State<StatefulWidget> createState() {
    return FlutterAppState();
  }
}

class FlutterAppState extends State<FlutterApp> {
  @override
  void initState() {
    super.initState();

    // TODO: Initialize any global services
    // - Push Notifications
    // - Crash Reporting (Firebase crashlytics)
    // - Connectivity monitoring
  }

  final theme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    bottomAppBarColor: Colors.blue,
  );

  Widget determineHomeScreen() {
    // TODO: Add logic to determine the home screen of the app
    return HomePage(widget.state);
  }

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     // TODO: Add providers for app data
    //   ],
    //   child: MaterialApp(
    //     title: widget.appName,
    //     theme: theme,
    //     home: determineHomeScreen(widget.state),
    //     routes: {
    //       HomePage.tag: (_) => HomePage(),
    //     },
    //     navigatorKey: SharedState.navigatorKey,
    //     navigatorObservers: [],
    //   ),
    // );
    return MaterialApp(
      title: widget.appName,
      theme: theme,
      home: determineHomeScreen(),
      routes: {
        HomePage.tag: (_) => HomePage(widget.state),
      },
      navigatorKey: SharedState.navigatorKey,
      navigatorObservers: [],
    );
  }

  @override
  void dispose() async {
    // TODO: dispose of any global services that were initialized
    super.dispose();
  }
}
