import 'dart:developer';

import 'package:flutter/material.dart';

import 'counter_storage.dart';
import 'gap_demo.dart';

void main() {
    log(const String.fromEnvironment('app.flavor'));
    log((const String.fromEnvironment('app.flavor') == "prod").toString());
    log((const String.fromEnvironment('app.flavor') == "dev").toString());
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: const String.fromEnvironment('app.flavor') == "dev" ? true: false,
      title: 'Gap',
      home: GapDemo(storage: CounterStorage(), debugMode: const String.fromEnvironment('app.flavor') == "dev" ? true: false),
    ),
  );
}

