import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:think_lite/screens/home_page.dart';
import 'package:think_lite/screens/overlay_page.dart';
import 'package:think_lite/screens/permission_page.dart';
import 'package:think_lite/service/monitoring_service.dart';
import 'package:think_lite/utils/permission_controller.dart';

void main() async {

  // await _initialize();

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


// This is the isolate entry for the Alert Window Service
// It needs to be added in the main.dart file with the name "overlayMain"...(jugaadu code max by plugin dev)
@pragma("vm:entry-point")
void overlayMain() async {
  debugPrint("Starting Alerting Window Isolate!");
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverlayWidget()
  ));
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






