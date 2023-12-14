import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:think_lite/screens/home_page.dart';
import 'package:think_lite/service/monitoring_service.dart';

void main() async {

  await _initialize();
  runApp(const MyApp());
}

_initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  await startMonitoringService();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}


