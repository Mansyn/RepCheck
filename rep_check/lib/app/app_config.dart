import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rep_check/state/shared_state.dart';

import 'app.dart';

enum AppEnvironment {
  development,
  staging,
  production,
  testing,
}

class FlutterAppConfig {
  FlutterAppConfig({
    @required this.appName,
    @required this.environment,
    @required this.apiBaseUrl,
    this.initializeCrashlytics = true,
    this.monitorConnectivity = true,
    this.enableCrashlyiticsInDevMode = true,
  });

  final String appName;
  final AppEnvironment environment;
  final String apiBaseUrl;
  final bool initializeCrashlytics,
      monitorConnectivity,
      enableCrashlyiticsInDevMode;

  Future<SharedState> loadState() async {
    // TODO: load state
    return SharedState();
  }

  Widget createApp(SharedState state) {
    return FlutterApp(
      appName: this.appName,
      state: state,
    );
  }

  Future run() async {
    final _state = await loadState();
    runApp(createApp(_state));
  }
}
