import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


const String STOP_MONITORING_SERVICE_KEY = "stop";
const String SET_APPS_NAME_FOR_MONITORING_KEY = "setAppsNames";
const String APP_NAMES_LIST_KEY = "appNames";

Future<void> startMonitoringService() async {
  final monitoringService = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'think_lite_foreground', // id
    'Think Lite Foreground Service', // title
    description:
    'This channel is used for think lite notifications.', // description
    importance: Importance.low,

    // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);


  IosConfiguration iosConfiguration = IosConfiguration();


  // Monitoring Service should have an OnBoot Broadcast Receiver Attached as well
  // It would also popup a notification signifying its running status
  AndroidConfiguration androidConfiguration = AndroidConfiguration(
    onStart: onMonitoringServiceStart,
    autoStart: true,
    isForegroundMode: true,
    autoStartOnBoot: true,
    notificationChannelId: 'think_lite_foreground',
    initialNotificationTitle: 'Think Lite',
    initialNotificationContent: 'Initializing...',
    foregroundServiceNotificationId: 888,

  );

  await monitoringService.configure(
      iosConfiguration: iosConfiguration,
      androidConfiguration: androidConfiguration
  );

  monitoringService.startService();


}


// Entry Point for Monitoring Isolate
@pragma('vm:entry-point')
onMonitoringServiceStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();



  // Stop this background service
  _registerListener(service);

  _startTimer();
}

Future<void> _startTimer() async{

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Timer.periodic(const Duration(seconds: 1), (timer) async{
    flutterLocalNotificationsPlugin.show(
      888,
      'Think Lite',
      '${DateTime.now()}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'think_lite_foreground',
          'Think Lite Foreground Service',
          icon: 'ic_bg_service_small',
          ongoing: true,
        ),
      ),
    );


  });
}


_registerListener(ServiceInstance service){
  service.on(STOP_MONITORING_SERVICE_KEY).listen((event) {
    service.stopSelf();
  });
}