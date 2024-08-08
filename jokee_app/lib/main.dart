import 'dart:async';
import 'package:flutter/material.dart';
import 'data/di/dependence_injection.dart';
import 'my_app.dart';

void main() => runZonedGuarded(_runMyApp, _reportError);

Future<void> _runMyApp() async {
  await initDependence();
  runApp(MyApp.runWidget());
}

void _reportError(Object error, StackTrace stackTrace) {
  // report by Firebase Crashlytics
}