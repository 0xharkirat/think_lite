import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:think_lite/screens/home_page.dart';
import 'package:think_lite/screens/permission_page.dart';
import 'package:think_lite/service/monitoring_service.dart';
import 'package:think_lite/utils/permission_controller.dart';

void main() async {

  await _initialize();

  bool permissionsAvailable = await PermissionController().checkPermissions();

  runApp(MyApp(
    home: !permissionsAvailable?  const MyApp(home: PermissionsPage()): const MyApp(home: HomePage()),

  ));
}

_initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  await startMonitoringService();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.home});

  final Widget home;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: home,
    );
  }
}


